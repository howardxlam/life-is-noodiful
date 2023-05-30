package com.howard.restaurant.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.howard.restaurant.models.LoginUser;
import com.howard.restaurant.models.User;
import com.howard.restaurant.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/users")
public class UserController {
	
	private final UserService userServ;

	public UserController(UserService userServ) {
		this.userServ = userServ;
	}
	
	@GetMapping("/login/register")
	public String loginReg(@ModelAttribute("newUser") User user, Model model) {
		model.addAttribute("loginUser", new LoginUser());
		return "user/index.jsp";
	}
	
	@PostMapping("/process/register")
	public String processRegister(@Valid @ModelAttribute("newUser") User user, BindingResult result, Model model,HttpSession session) {
		if(userServ.getUser(user.getEmail()) != null) {
			result.rejectValue("email", "Unique" ,"Email is already in use");
		}
		if(!user.getPassword().equals(user.getConfirm())) {
			result.rejectValue("password", "Match" ,"Passwords don't match");
		}
		if(result.hasErrors()) {
			model.addAttribute("loginUser", new LoginUser());
			return "user/index.jsp";
		}
		
		User newUser = userServ.createUser(user);
		session.setAttribute("user_id", newUser.getId());
		return "redirect:/orders/new";
	}
	
	@PostMapping("/process/login")
	public String processLogin(@Valid @ModelAttribute("loginUser") LoginUser loginUser,BindingResult result,Model model, HttpSession session) {
		User loggingUser = userServ.login(loginUser, result);
		if(result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "user/index.jsp";
		}
		session.setAttribute("user_id", loggingUser.getId());
		return "redirect:/orders/new";		
	}
	
	@GetMapping("/logout")
	public String logoutUser(HttpSession session) {
		session.invalidate();
		return "redirect:/users/login/register";
	}

}