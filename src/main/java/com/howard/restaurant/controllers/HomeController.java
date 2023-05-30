package com.howard.restaurant.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.howard.restaurant.services.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	
	private final UserService userService;
	
	public HomeController(UserService userService) {
		this.userService = userService;
	}	

	@GetMapping("/")
	public String home(HttpSession session, Model model) {
	    Long userId = (Long) session.getAttribute("user_id");
	    if (userId != null) {
	        model.addAttribute("loggedInUser", userService.getUser(userId));
	    }
	    return "main/index.jsp";
	}
	
	@GetMapping("/about")
	public String about(HttpSession session, Model model) {
	    Long userId = (Long) session.getAttribute("user_id");
	    if (userId != null) {
	        model.addAttribute("loggedInUser", userService.getUser(userId));
	    }
		return "main/about.jsp";
	}

}
