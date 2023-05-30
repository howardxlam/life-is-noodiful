package com.howard.restaurant.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.howard.restaurant.models.User;
import com.howard.restaurant.models.Order;

@Repository
public interface OrderRepository extends CrudRepository<Order, Long> {
    List<Order> findByUserId(Long userId);
    List<Order> findByUser(User user);
    Long countByUser(User user);
}