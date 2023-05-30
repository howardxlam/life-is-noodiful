<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/css/style.css">
    <title>Add location</title>
</head>
<body class="bg-dark">
    <nav class="navbar m-2">
        <a href="/" class="text-no-decoration">
            <h3 class="text-light">Restaurant</h3>
        </a>
        <div class="dropdown show">
            <a class="btn dropdown-toggle border border-white" href="#" role="button"
                id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                aria-expanded="false">
                <div class="hamburger"></div>
                <div class="hamburger"></div>
                <div class="hamburger"></div>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuLink">
                <a class="dropdown-item" href="#">Order Online</a>
                <a class="dropdown-item" href="#">Menu</a>
                <a class="dropdown-item" href="#">Locations</a>
                <a class="dropdown-item" href="/about">About Us</a>
                <a class="dropdown-item" href="#">Something else</a>
            </div>
        </div>
    </nav>

    <div class="container text-white">
        <h1>Add Location</h1>

        <form action="/locations/process/new" method="post">

            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" class="form-control" id="address" name="address" required>
            </div>
            
            <div class="form-group">
                <label for="city">City</label>
                <input type="text" class="form-control" id="city" name="city" required>
            </div>

            <div class="form-group">
                <label for="latitude">Latitude</label>
                <input type="text" class="form-control" id="latitude" name="latitude" required>
            </div>

            <div class="form-group">
                <label for="longitude">Longitude</label>
                <input type="text" class="form-control" id="longitude" name="longitude" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
            </div>

            <div class="form-group">
                <label for="hours">Hours</label>
                <input type="text" class="form-control" id="hours" name="hours" required>
            </div>

            <div class="form-group">
                <label for="image1">Image 1</label>
                <input type="text" class="form-control" id="image1" name="image1" required>
            </div>

            <div class="form-group">
                <label for="image2">Image 2</label>
                <input type="text" class="form-control" id="image2" name="image2" required>
            </div>

            <button type="submit" class="btn btn-primary">Add Location</button>
        </form>
    </div>


    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"></script>
</body>
</html>