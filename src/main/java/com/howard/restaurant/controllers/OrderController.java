package com.howard.restaurant.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.howard.restaurant.models.CreditCard;
import com.howard.restaurant.models.Food;
import com.howard.restaurant.models.Location;
import com.howard.restaurant.models.Order;
import com.howard.restaurant.models.OrderItem;
import com.howard.restaurant.models.User;
import com.howard.restaurant.services.FoodService;
import com.howard.restaurant.services.LocationService;
import com.howard.restaurant.services.OrderService;
import com.howard.restaurant.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
@Controller
@RequestMapping("/orders")
public class OrderController {

    private final FoodService foodService;
    private final OrderService orderService;
    private List<Food> bagItems = new ArrayList<>();
	private UserService userService;
	private LocationService locationService;

    public OrderController(FoodService foodService, OrderService orderService, UserService userService, LocationService locationService) {
        this.foodService = foodService;
        this.orderService = orderService;
        this.userService = userService;
        this.locationService = locationService;
    }
    
    @GetMapping("/new")
    public String createOrder(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("user_id");
        if (userId == null) {
            return "redirect:/users/login/register";
        }
	    if (userId != null) {
	        model.addAttribute("loggedInUser", userService.getUser(userId));
	    }
        List<Food> foods = foodService.getAll();
        Map<String, List<Food>> foodsByCategory = new HashMap<>();

        for (Food food : foods) {
            String category = food.getCategory();
            List<Food> categoryFoods = foodsByCategory.getOrDefault(category, new ArrayList<>());
            categoryFoods.add(food);
            foodsByCategory.put(category, categoryFoods);
        }
        List<Location> locations = locationService.getAllLocations();
        model.addAttribute("locations", locations);
        model.addAttribute("foodsByCategory", foodsByCategory);
        return "order/create.jsp";
    }

    @PostMapping("/addToBag")
    public String addToBag(HttpSession session, Model model, @RequestParam("foodId") Long foodId, @RequestParam("quantity") int quantity) {
        Long userId = (Long) session.getAttribute("user_id");
        if (userId != null) {
            model.addAttribute("loggedInUser", userService.getUser(userId));
        }
        Food food = foodService.findFood(foodId);
        if (food != null) {
            boolean itemExists = false;
            for (Food item : bagItems) {
                if (item.getId().equals(foodId)) {
                    int updatedQuantity = item.getQuantity() + quantity;
                    item.setQuantity(updatedQuantity);
                    itemExists = true;
                    break;
                }
            }
            
            if (!itemExists) {
                Food bagItem = new Food();
                bagItem.setId(food.getId());
                bagItem.setName(food.getName());
                bagItem.setDescription(food.getDescription());
                bagItem.setPrice(food.getPrice());
                bagItem.setQuantity(quantity);
                bagItems.add(bagItem);

                OrderItem orderItem = new OrderItem();
                orderItem.setFood(food);
                orderItem.setQuantity(quantity);
                
                Order order = (Order) session.getAttribute("order");
                if (order == null) {
                    order = new Order();
                    session.setAttribute("order", order);
                }
                
                order.addOrderItem(orderItem); 
            }
        }
        return "redirect:/orders/new";
    }
    
    @PostMapping("/removeFromBag")
    public String removeFromBag(Model model, @RequestParam("foodId") Long foodId, @RequestParam("locationId") Long locationId, @RequestParam("quantity") int quantity) {

        if (quantity <= 0) {
            bagItems.removeIf(item -> item.getId().equals(foodId));
        } else {
            for (Food item : bagItems) {
                if (item.getId().equals(foodId)) {
                    item.setQuantity(quantity);
                    break;
                }
            }
        }
        
        Location location = locationService.getLocationById(locationId);
        model.addAttribute("location", location);
        
        return "redirect:/orders/checkout?locationId=" + locationId;
    }
    

    @GetMapping("/checkout")
    public String checkout(@RequestParam("locationId") Long locationId, Model model, HttpSession session) {
    	Long userId = (Long) session.getAttribute("user_id");
	    if (userId != null) {
	        model.addAttribute("loggedInUser", userService.getUser(userId));
	    }
        List<Location> locations = locationService.getAllLocations();
        model.addAttribute("locations", locations);
        Location location = locationService.getLocationById(locationId);
        session.setAttribute("bagItems", bagItems); 
        double total = calculateTotal();
        model.addAttribute("locationId", locationId);
        model.addAttribute("location", location);
        model.addAttribute("total", total);
        model.addAttribute("creditCard", new CreditCard()); 
        return "order/checkout.jsp";
    }

    private double calculateTotal() {
        double total = 0.0;
        for (Food item : bagItems) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }
    

    @PostMapping("/checkout")
    public String processOrder(@Valid @ModelAttribute("creditCard") CreditCard creditCard, BindingResult results, @RequestParam("locationId") Long locationId, Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("user_id");
        if (userId != null) {
            model.addAttribute("loggedInUser", userService.getUser(userId));
        }

        if (results.hasErrors()) {
            model.addAttribute("bagItems", session.getAttribute("bagItems"));
            model.addAttribute("locationId", locationId); 
            return "order/checkout.jsp";
        }

        if (!isValidCreditCardNumber(creditCard.getCardNumber())) {
            results.rejectValue("cardNumber", "error.creditCard", "Invalid credit card number");
            model.addAttribute("bagItems", session.getAttribute("bagItems"));
            return "order/checkout.jsp";
        }

        @SuppressWarnings("unchecked")
        List<Food> bagItems = (List<Food>) session.getAttribute("bagItems");
        double total = calculateTotal();

        User user = userService.getUser(userId);

        Order order = new Order();
        order.setUser(user);
        order.setFoods(new ArrayList<>()); 
        for (Food bagItem : bagItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setFood(bagItem);
            orderItem.setQuantity(bagItem.getQuantity());
            order.addOrderItem(orderItem); 
            order.getFoods().add(bagItem); 
        }

        Location location = locationService.getLocationById(locationId);
        order.setLocation(location);
        orderService.create(order);
        
        session.removeAttribute("bagItems");

        model.addAttribute("creditCard", creditCard);
        model.addAttribute("bagItems", bagItems);
        model.addAttribute("total", total);
        model.addAttribute("user", user);
        model.addAttribute("location", location);

        String maskedCardNumber = maskCardNumber(creditCard.getCardNumber());
        model.addAttribute("creditCardNumber", creditCard.getCardNumber());
        model.addAttribute("lastFourDigits", maskedCardNumber);

        return "order/confirm.jsp";
    }
    
    
    private boolean isValidCreditCardNumber(String cardNumber) {
        cardNumber = cardNumber.replaceAll("\\s|-", "");

        int sum = 0;
        boolean alternate = false;
        for (int i = cardNumber.length() - 1; i >= 0; i--) {
            int digit = Integer.parseInt(cardNumber.substring(i, i + 1));
            if (alternate) {
                digit *= 2;
                if (digit > 9) {
                    digit = (digit % 10) + 1;
                }
            }
            sum += digit;
            alternate = !alternate;
        }
        
        return (sum % 10) == 0;
    }

    private String maskCardNumber(String cardNumber) {
        if (cardNumber == null || cardNumber.isEmpty()) {
            return "";
        }
        
        int count = Math.max(cardNumber.length() - 4, 0);
        String mask = "*".repeat(count);
        String lastFourDigits = cardNumber.substring(cardNumber.length() - 4);
        return mask + lastFourDigits;
    }
    
    @GetMapping("/past")
    public String showPastOrders(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("user_id");
        if (userId != null) {
            model.addAttribute("loggedInUser", userService.getUser(userId));
        }
        List<Order> pastOrders = orderService.getAllOrdersForUser(userId);
        for (Order order : pastOrders) {
            double total = 0.0;
            for (OrderItem orderItem : order.getOrderItems()) {
                total += orderItem.getFood().getPrice() * orderItem.getQuantity();
            }
            order.setTotal(total);
            
        }
        
        
        model.addAttribute("pastOrders", pastOrders);
        return "user/past.jsp";
    }
    
}