<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/style.css">
<script
		src="https://maps.googleapis.com/maps/api/js?key=API_KEY&callback=initMap"></script>

<title>Our Locations</title>
</head>
<body class="bg-dark">
	<div class="navbar m-2">
		<h3><a href="/" class="text-no-decoration text-light">Life Is Noodiful</a></h3>
		<div class="d-flex align-items-center">
			<c:if test="${loggedInUser != null}">
				<h4 class="text-white mr-5">${loggedInUser.firstName }</h4>
			</c:if>
		<div class="dropdown show">
			<a class="btn border border-white hover" href="#"
				role="button" id="dropdownMenuLink" data-toggle="dropdown"
				aria-haspopup="true" aria-expanded="false">
				<div class="hamburger"></div>
				<div class="hamburger"></div>
				<div class="hamburger"></div>
			</a>

			<div class="dropdown-menu dropdown-menu-right"
				aria-labelledby="dropdownMenuLink">
				<a class="dropdown-item" href="/orders/new">Order Online</a> 
				<a class="dropdown-item" href="/foods/menu">Menu</a> 
				<a class="dropdown-item" href="/locations/">Locations</a> 
				<a class="dropdown-item" href="/about">About Us</a> 
				<c:if test="${loggedInUser != null}">
					<a class="dropdown-item" href="/orders/past">Past Orders</a>
				</c:if>
				<c:if test="${loggedInUser != null}">
					<a class="dropdown-item" href="/users/logout">Logout</a>
				</c:if>
				<c:if test="${loggedInUser == null}">
					<a class="dropdown-item" href="/users/login/register">Login/Register</a>
				</c:if>
			</div>
		</div>
		</div>
	</div>
	<div class="container text-white">
		<h1 class="mb-3">Locations</h1>
		
		<div class="d-flex justify-content-end">
 			<form action="/locations/" method="get">
    			<div class="form-group d-flex align-items-center">
        			<label for="sort" class="w-100">Sort by:</label>
        			<select name="sort" id="sort" class="form-control ssort">
            			<option value="city">City</option>
            			<option value="distance">Distance</option>
        			</select>
        			<input type="hidden" name="latitude" id="latitude">
        			<input type="hidden" name="longitude" id="longitude">
        			<button type="submit" class="btn btn-primary ml-3">Sort</button>
    			</div>
			</form>
		</div>

		<div class="accordion text-secondary" id="locationAccordion">
			<c:forEach items="${locations}" var="location">
				<div class="card bg-light">
					<div class="card-header" id="heading${location.id}" data-latitude="${location.latitude}" data-longitude="${location.longitude}">
						<h2 class="mb-0">
							<button class="btn btn-link w-100" type="button"
								data-toggle="collapse" data-target="#collapse${location.id}"
								aria-expanded="true" aria-controls="collapse${location.id}">
								<div class="row text-left">
									<div class="col col-4">
										<p>${location.city}</p>
									</div>
									<div class="col col-5">
										<p>${location.name}</p>
									</div>
									<div class="col col-3">
										<p class="text-dark text-no-decoration">
											Distance: <span id="distance-${location.id}"></span> miles
										</p>
									</div>

								</div>
							</button>
						</h2>
					</div>

					<div id="collapse${location.id}" class="collapse"
						aria-labelledby="heading${location.id}"
						data-parent="#locationAccordion">
						<div class="card-body">
							<div class="row">
								<div class="col-md-6">
									<p>${location.hours}</p>
									<p>${location.description}</p>
								</div>
								<div class="col-md-6">
									<p class="text-right">${location.address }, ${location.city }</p>
                                <div id="map-${location.id}" style="height: 400px"></div>


<script>
function initMap_${location.id}() {
    var latitude = parseFloat(document.getElementById("heading${location.id}").dataset.latitude);
    var longitude = parseFloat(document.getElementById("heading${location.id}").dataset.longitude);

    var map = new google.maps.Map(document.getElementById("map-${location.id}"), {
        zoom: 12,
        center: { lat: latitude, lng: longitude }
    });

    var marker = new google.maps.Marker({
        position: { lat: latitude, lng: longitude },
        map: map,
        title: '${location.name}'
    });

    calculateDistance(latitude, longitude, function(distance) {
        var distanceElement = document.getElementById("distance-${location.id}");
        distanceElement.textContent = convertToMiles(distance).toFixed(1);
        var card = document.getElementById("heading${location.id}");
        card.dataset.distance = distance;
        card.dataset.sortValue = distance; // Add this line
    });
}

function calculateDistance(latitude, longitude, callback) {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var userLat = position.coords.latitude;
            var userLng = position.coords.longitude;
            var distance = calculateDistanceInKm(userLat, userLng, latitude, longitude);
            callback(distance);

            var latitudeInput = document.getElementById("latitude");
            var longitudeInput = document.getElementById("longitude");
            latitudeInput.value = userLat;
            longitudeInput.value = userLng;

            var accordionButton = document.querySelector(`#heading${location.id} button`);
            accordionButton.dataset.distance = distance;
        });
    } else {
        console.log("Geolocation is not supported by this browser.");
    }
}

function calculateDistanceInKm(lat1, lon1, lat2, lon2) {
  const earthRadiusKm = 6371; 
  const dLat = degreesToRadians(lat2 - lat1);
  const dLon = degreesToRadians(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(degreesToRadians(lat1)) *
    Math.cos(degreesToRadians(lat2)) *
    Math.sin(dLon / 2) *
    Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const distanceKm = earthRadiusKm * c;
  return distanceKm;
}

function convertToMiles(distanceKm) {
  const milesConversionFactor = 0.621371; 
  return distanceKm * milesConversionFactor;
}

function degreesToRadians(degrees) {
  return (degrees * Math.PI) / 180;
}




window.addEventListener('load', initMap_${location.id});
</script>


									
						
								</div>
							</div>
							<div class="d-flex mt-4">
								<img src="${location.image1}" class="img-fluid col col-6" alt="Image 1">
								<img src="${location.image2}" class="img-fluid col col-6" alt="Image 2">
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"></script>
	

</body>
</html>