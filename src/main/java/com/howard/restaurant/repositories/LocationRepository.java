package com.howard.restaurant.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.howard.restaurant.models.Location;


@Repository
public interface LocationRepository extends CrudRepository<Location, Long> {
    Location findById(long id);
	List<Location> findAll();
}

