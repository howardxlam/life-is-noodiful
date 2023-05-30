<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/css/style.css">
    <title>Place an Order</title>
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

    <div class="container">
        <c:forEach items="${foodsByCategory}" var="categoryEntry">
            <h2 class="text-light">${categoryEntry.key}</h2>
            <table class="table mt-4 text-white bg-dark border">
                <thead>
                    <tr>
                        <th class="col col-3">Name</th>
                        <th class="col col-7">Description</th>
                        <th class="col col-1">Price</th>
                        <th class="col col-1">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categoryEntry.value}" var="food">
                        <tr class="food-row" data-toggle="collapse" data-target="#food-details-${food.id}" aria-expanded="false">
                            <td class="font-weight-bold">${food.name}</td>
                            <td>${food.description}</td>
                            <td><fmt:formatNumber value="${food.price}" type="currency"/></td>
                            <td onclick="event.stopPropagation()">
                                <form action="/orders/addToBag" method="post" >
                                    <input type="hidden" name="foodId" value="${food.id}">
                                    <div class="form-group d-flex">
                                        <input type="number" name="quantity" value="1" min="1" class="form-control quantity">
                                    <button type="submit" class="btn btn-primary">+</button>
                                    </div>
                                </form>
                            </td>
                        </tr>
                        <tr id="food-details-${food.id}" class="collapse">
                            <td colspan="4" class="border border-top-0">
                                <div class=" row food-details">
                                    <div class="col col-6 dietary">
                                    	<h4>Ingredients:</h4>
                                    	<p class="mb-4">${food.ingredients}</p>
                                    	<c:if test="${food.vegetarian}">
                                        	<p><img src="https://i.imgur.com/1Yz5G91.png">Vegetarian</p>
                                  	 	</c:if>
                                  	  	<c:if test="${food.vegan}">
                                        	<p><img src="https://i.imgur.com/FFR0Lm8.png">Vegan</p>
                                   		</c:if>
                                    	<c:if test="${food.glutenFree}">
                                        	<p><img src="https://i.imgur.com/E7Akvgt.png">Gluten-free</p>
                                    	</c:if>
                                    	<c:if test="${food.noPeanuts}">
                                        	<p><img src="https://i.imgur.com/OUoS2Q4.png">No Peanuts</p>
                                    	</c:if>
                                    </div>
                                    <div class="col col-6">
                                   		<img src="${food.image}" alt="${food.name}" class="food-image w-100">
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:forEach>
        
		<form action="/orders/checkout" method="get">
    		<div class="form-group text-white bg-dark p-4 d-flex border border-white align-items-center">
        		<label for="location" class="col col-5 my-auto"><h4>Select a Location:</h4></label>
        		<select name="locationId" id="location" class="form-control">
            		<c:forEach items="${locations}" var="location">
                		<option value="${location.id}">${location.city} - ${location.name}</option>
            		</c:forEach>
        		</select>
    		</div>
    		<div class="d-flex justify-content-end">
    		<button type="submit" class="btn btn-primary mb-5 px-5">Checkout</button>
    		</div>
		</form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"></script>
</body>
</html>
                                    