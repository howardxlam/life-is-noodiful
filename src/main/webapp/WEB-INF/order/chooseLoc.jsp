<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<title>Project</title>
</head>

<body class="bg-dark">

	<div class="navbar m-2">
		<h3><a href="/" class="text-no-decoration text-light">Restaurant</a></h3>
		<div class="d-flex align-items-center">
			<c:if test="${loggedInUser != null}">
				<h4 class="text-white mr-5">Welcome, ${loggedInUser.firstName }</h4>
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
	
	     <h2 class="text-light">Choose Location</h2>

        <form action="/orders/processLocation" method="post">
            <div class="form-group text-dark">
                <label for="location">Select a Location:</label>
                <select name="locationId" id="location" class="form-control">
                    <c:forEach items="${locations}" var="location">
                        <option value="${location.id}">${location.name}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Continue</button>
        </form>
	
	
	
	
	
	</div>

</body>
</html>