package com.howard.restaurant.controllers;


import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.howard.restaurant.models.Location;
import com.howard.restaurant.services.LocationService;
import com.howard.restaurant.services.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/locations")
public class LocationController {

    private final LocationService locationService;
    private final UserService userService;

    public LocationController(LocationService locationService, UserService userService) {
        this.locationService = locationService;
        this.userService = userService;
    }

    @GetMapping("/")
    public String getAllLocations(
        HttpSession session,
        Model model,
        @RequestParam(name = "sort", required = false) String sort,
        @RequestParam(name = "latitude", required = false) Double latitude,
        @RequestParam(name = "longitude", required = false) Double longitude
    ) {
        Long userId = (Long) session.getAttribute("user_id");
        if (userId != null) {
            model.addAttribute("loggedInUser", userService.getUser(userId));
        }

        List<Location> locations = locationService.getAllLocations();

        if (sort != null && sort.equals("distance") && latitude != null && longitude != null) {
            locations.sort(Comparator.comparingDouble(location -> calculateDistanceInKm(latitude, longitude, location.getLatitude(), location.getLongitude())));
        } else if (sort != null && sort.equals("city")) {
            locations.sort(Comparator.comparing(Location::getCity));
        }

        model.addAttribute("locations", locations);
        return "location/index.jsp";
    }
    
    private double calculateDistanceInKm(double lat1, double lon1, double lat2, double lon2) {
        final int earthRadiusKm = 6371;

        double lat1Rad = Math.toRadians(lat1);
        double lon1Rad = Math.toRadians(lon1);
        double lat2Rad = Math.toRadians(lat2);
        double lon2Rad = Math.toRadians(lon2);

        double deltaLat = lat2Rad - lat1Rad;
        double deltaLon = lon2Rad - lon1Rad;

        double a = Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2)
                + Math.cos(lat1Rad) * Math.cos(lat2Rad)
                * Math.sin(deltaLon / 2) * Math.sin(deltaLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distance = earthRadiusKm * c;

        return distance;
    }
    
    

    @GetMapping("/{id}")
    public String getLocationById(@PathVariable("id") Long id, Model model) {
        Location location = locationService.getLocationById(id);
        model.addAttribute("location", location);
        return "location/details"; 
    }

    @GetMapping("/new")
    public String createLocationForm(Model model) {
        Location location = new Location();
        model.addAttribute("location", location);
        return "location/create.jsp"; 
    }

    @PostMapping("/process/new")
    public String processNewLocation(@ModelAttribute Location location) {
        locationService.saveLocation(location);
        return "redirect:/"; // 
    }

    @GetMapping("/{id}/edit")
    public String editLocationForm(@PathVariable("id") Long id, Model model) {
        Location location = locationService.getLocationById(id);
        model.addAttribute("location", location);
        return "location/edit"; 
    }

    @PostMapping("/{id}/edit")
    public String editLocation(@PathVariable("id") Long id, @ModelAttribute("location") Location updatedLocation) {
        Location location = locationService.getLocationById(id);
        location.setName(updatedLocation.getName());
        location.setAddress(updatedLocation.getAddress());
        locationService.saveLocation(location);
        return "redirect:/locations"; 
    }

    @PostMapping("/{id}/delete")
    public String deleteLocation(@PathVariable("id") Long id) {
        locationService.deleteLocationById(id);
        return "redirect:/locations";
    }


}
