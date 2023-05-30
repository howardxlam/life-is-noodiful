package com.howard.restaurant.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.howard.restaurant.models.Order;
import com.howard.restaurant.models.User;
import com.howard.restaurant.repositories.OrderRepository;


@Service
public class OrderService {

	private final UserService userService;
	private final OrderRepository orderRepository;

	public OrderService(OrderRepository orderRepository, UserService userService) {
		this.orderRepository = orderRepository;
		this.userService = userService;
	}

	public List<Order> getAll() {
		return (List<Order>) orderRepository.findAll();
	}

	public Order create(Order order) {
		order.setCreatedAt();
		return orderRepository.save(order);
	}

	public Order findOrder(Long id) {
		Optional<Order> optionalOrder = orderRepository.findById(id);
		if (optionalOrder.isPresent()) {
			return optionalOrder.get();
		} else {
			return null;
		}
	}

	public Order updateOrder(Order order) {
		return orderRepository.save(order);
	}

	public void deleteOrder(Long id) {
		Optional<Order> optionalOrder = orderRepository.findById(id);
		if (optionalOrder.isPresent()) {
			orderRepository.deleteById(id);
		}
	}
	
    public Order createOrder(Order order) {
        return orderRepository.save(order);
    }
	
    public List<Order> getAllOrdersForUser(Long userId) {
        User user = userService.getUser(userId);
        return orderRepository.findByUser(user);
    }

}