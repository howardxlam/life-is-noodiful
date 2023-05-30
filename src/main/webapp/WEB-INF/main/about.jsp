<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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

<title>About Us</title>
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

		<div class="text-white mb-5">
			<h1 class="display-4">About Us</h1>
			<p class="col col-6 lead">Lorem ipsum dolor sit amet consectetur adipisicing elit. Vitae
				laborum quae dolorem debitis, consequatur eius tenetur impedit earum
				fugit quaerat. Incidunt pariatur exercitationem eaque iure suscipit
				sunt labore adipisci quo.</p>
			<p class="col col-5 lead">Lorem ipsum dolor sit amet consectetur adipisicing elit. Vitae
				laborum quae dolorem debitis, consequatur eius tenetur impedit earum
				fugit quaerat. Incidunt pariatur exercitationem eaque iure suscipit
				sunt labore adipisci quo.</p>
			<p class="col col-4 lead">Lorem ipsum dolor sit amet consectetur adipisicing elit. Vitae
				laborum quae dolorem debitis, consequatur eius </p>
			<p class="col col-3 lead">tenetur impedit earum
				fugit quaerat. Incidunt pariatur exercitationem eaque iure suscipit
				sunt labore adipisci quo.</p>

		</div>

	</div>




<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-KyZXEAg3QhqLMpG8r+6+qD1IrqBjzx6TIo4KP8ATD9c3+qZg4NLgS6kUztk27g2N"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"
        integrity="sha384-pzjw6VHRKz5jbz8b8Vv2v4PA8FyYv4N9rpaAz8+QyG3p8CC7ABWSvoX83bZ4bT+q"
        crossorigin="anonymous"></script>
</body>

</html>