package com.howard.restaurant.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.howard.restaurant.models.Food;



@Repository
public interface FoodRepository extends CrudRepository<Food, Long> {
    Food findById(long id);
	List<Food> findAll();
}
