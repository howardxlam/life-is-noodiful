package com.howard.restaurant.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.howard.restaurant.models.LoginUser;
import com.howard.restaurant.models.User;
import com.howard.restaurant.repositories.UserRepository;



@Service
public class UserService {
	
	private final UserRepository userRepo;

	public UserService(UserRepository userRepo) {
		this.userRepo = userRepo;
	}
	
	public User createUser(User registeringUser) {
		String hashed = BCrypt.hashpw(registeringUser.getPassword(), BCrypt.gensalt());
		registeringUser.setPassword(hashed);
		return userRepo.save(registeringUser);
		
	}
	
	public User getUser(String Email) {
		Optional<User> potentialUser = userRepo.findByEmail(Email);
		return potentialUser.isPresent() ? potentialUser.get() : null;
	}
	
	public User getUser(Long id) {
		Optional<User> potentialUser = userRepo.findById(id);
		return potentialUser.isPresent() ? potentialUser.get() : null;
	}
	
	public User login(LoginUser loginUser, BindingResult result) {
		if(result.hasErrors()) {
			return null;
		}
		User existingUser = getUser(loginUser.getEmail());
		if(existingUser == null) {
			result.rejectValue("email", "Unique", "Email does not exist");
			return null;
		}
		if(!BCrypt.checkpw(loginUser.getPassword(), existingUser.getPassword())) {
			result.rejectValue("email", "Unique", "Wrong password");
			return null;
		}
		
		return existingUser;
	}

}