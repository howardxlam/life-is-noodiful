package com.howard.restaurant.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.howard.restaurant.models.Food;
import com.howard.restaurant.repositories.FoodRepository;

@Service
public class FoodService {

	private final FoodRepository foodRepository;

	public FoodService(FoodRepository foodRepository) {
		this.foodRepository = foodRepository;
	}

	public List<Food> getAll() {
		return foodRepository.findAll();
	}

	public Food create(Food food) {
		return foodRepository.save(food);
	}

	public Food findFood(Long id) {
		Optional<Food> optionalFood = foodRepository.findById(id);
		if (optionalFood.isPresent()) {
			return optionalFood.get();
		} else {
			return null;
		}
	}

	public Food updateFood(Food food) {
		return foodRepository.save(food);
	}

	public void deleteFood(Long id) {
		Optional<Food> optionalFood = foodRepository.findById(id);
		if (optionalFood.isPresent()) {
			foodRepository.deleteById(id);
		}
	}
	
    public Food getFoodById(Long id) {
		Optional<Food> optionalFood = foodRepository.findById(id);
		if (optionalFood.isPresent()) {
			return optionalFood.get();
		} else {
			return null;
		}
    }
    

	

}