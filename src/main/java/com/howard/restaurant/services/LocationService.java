package com.howard.restaurant.services;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Service;

import com.howard.restaurant.models.Location;
import com.howard.restaurant.repositories.LocationRepository;

@Service
public class LocationService {

    private final LocationRepository locationRepository;

    public LocationService(LocationRepository locationRepository) {
        this.locationRepository = locationRepository;
    }

    public Location saveLocation(Location location) {
        return locationRepository.save(location);
    }

    public Location getLocationById(Long id) {
        return locationRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Location not found with id: " + id));
    }

    public List<Location> getAllLocations() {
        return locationRepository.findAll();
    }

    public void deleteLocationById(Long id) {
        locationRepository.deleteById(id);
    }
    
    public List<Location> getLocationsSortedByDistance(double userLatitude, double userLongitude) {
        List<Location> locations = locationRepository.findAll();
        List<Location> sortedLocations = new ArrayList<>();

        for (Location location : locations) {
            double distance = calculateDistanceInKm(userLatitude, userLongitude, location.getLatitude(), location.getLongitude());
            location.setDistance(distance);
            sortedLocations.add(location);
        }
        sortedLocations.sort(Comparator.comparingDouble(Location::getDistance));

        return sortedLocations;
    }
    
    private double calculateDistanceInKm(double lat1, double lon1, double lat2, double lon2) {
        double earthRadiusKm = 6371;
        double lat1Rad = Math.toRadians(lat1);
        double lon1Rad = Math.toRadians(lon1);
        double lat2Rad = Math.toRadians(lat2);
        double lon2Rad = Math.toRadians(lon2);

        double deltaLat = lat2Rad - lat1Rad;
        double deltaLon = lon2Rad - lon1Rad;

        double a = Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2)
                + Math.cos(lat1Rad) * Math.cos(lat2Rad) * Math.sin(deltaLon / 2) * Math.sin(deltaLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distanceKm = earthRadiusKm * c;

        return distanceKm;
    }
	
}
