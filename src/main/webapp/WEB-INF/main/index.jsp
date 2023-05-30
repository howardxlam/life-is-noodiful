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


<title>Life Is Noodiful</title>
</head>

<body class="bg-dark">

	<div class="navbar m-2">
		<h3><a href="/" class="text-no-decoration text-light">Life Is Noodiful</a></h3>
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
			<h1 class="display-4">In the mood for noods?</h1>
			<p class="lead col col-6">Never a noodull moment, always a bowl-tiful moment.
			A meal you'll never pho-get. Too many noodles? That's impastable. It's ra-meant to be, 
			just call us a hopeless ramen-tic. Udon know how much we love noodles. 
			Noodles are the best things in life, you know what I Mein? Well this was Bun Cha fun.	
			</p>
		</div>

		<div class="text-white text-decoration-none homenav">
			<a href="/orders/new" class="btn btn-outline-light my-1 hover">Order Online</a><br>
			<a href="/foods/menu" class="btn btn-outline-light my-1 hover">Menu</a><br> 
			<a href="/locations/" class="btn btn-outline-light my-1 hover">Locations</a><br> 
			<a href="/about" class="btn btn-outline-light my-1 hover">About Us</a>
		</div>


	</div>




	<script src="./script.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-KyZXEAg3QhqLMpG8r+6+qD1IrqBjzx6TIo4KP8ATD9c3+qZg4NLgS6kUztk27g2N"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"
		integrity="sha384-pzjw6VHRKz5jbz8b8Vv2v4PA8FyYv4N9rpaAz8+QyG3p8CC7ABWSvoX83bZ4bT+q"
		crossorigin="anonymous"></script>
</body>

</html>