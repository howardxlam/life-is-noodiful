package com.howard.restaurant.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.howard.restaurant.models.Food;
import com.howard.restaurant.services.FoodService;
import com.howard.restaurant.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/foods")
public class FoodController {

	private final FoodService foodService;
	private final UserService userService;

	public FoodController(FoodService foodService, UserService userService) {
		this.foodService = foodService;
		this.userService = userService;
	}

	@GetMapping("/new")
	public String newFood(@ModelAttribute("food") Food food) {
		return "food/create.jsp";
	}
	
	@GetMapping("/menu")
	public String foodMenu(HttpSession session, Model model) {
	    Long userId = (Long) session.getAttribute("user_id");
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

        model.addAttribute("foodsByCategory", foodsByCategory);
		return "food/menu.jsp";
	}

	@PostMapping("/process/new")
	public String processCreateFood(@Valid @ModelAttribute("food") Food food, BindingResult result) {

		if (result.hasErrors()) {
			System.out.println(result);
			return "food/create.jsp";
		} else {
			foodService.create(food);
			return "redirect:/";
		}
	}

	@GetMapping("/{id}")
	public String deatil(@PathVariable("id") Long id, Model model) {
		Food food = foodService.findFood(id);
		model.addAttribute("food", food);
		return "/food/detail.jsp";
	}

	@GetMapping("/{id}/edit")
	public String show(@PathVariable("id") Long id, Model model) {
		Food food = foodService.findFood(id);
		model.addAttribute("food", food);
		return "food/edit.jsp";
	}

	@PutMapping("/{id}/update")
	public String updateFood(@Valid @ModelAttribute("food") Food food, BindingResult result,
			@PathVariable("id") Long id, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("food", food);
			return "food/edit.jsp";
		}
		foodService.updateFood(food);
		return "redirect:/";
	}

	@DeleteMapping("/{id}/delete")
	public String destroy(@PathVariable("id") Long id) {
		foodService.deleteFood(id);
		return "redirect:/";
	}
	
	

}