<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<title>Sign In / Register</title>
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


	
	
	<div class="container text-white">
	
		<div class="row justify-content-around">
			<div class="col col-4 bg-dark p-3 border border-white rounded">
				<h3>Register</h3>
				<form:form action="/users/process/register" method="post" modelAttribute="newUser">
				    <div class="form-group">
				        <label>First Name</label>
				        <form:input path="firstName" class="form-control" />
				        <form:errors path="firstName" class="text-danger" />
				    </div>
				    <div class="form-group">
				        <label>Last Name</label>
				        <form:input path="lastName" class="form-control" />
				        <form:errors path="lastName" class="text-danger" />
				    </div>
				    <div class="form-group">
				        <label>Email</label>
				        <form:input path="email" class="form-control" />
				        <form:errors path="email" class="text-danger" />
				    </div>
				    <div class="form-group">
				        <label>Password</label>
				        <form:input path="password" class="form-control" />
				        <form:errors path="password" class="text-danger" />
				    </div>
				    <div class="form-group">
				        <label>Confirm Password</label>
				        <form:input path="confirm" class="form-control" />
				        <form:errors path="confirm" class="text-danger" />
				    </div>
				    <input type="submit" value="Register User" class="btn btn-primary" />
				</form:form>
			</div>
			<div class="col col-4 bg-dark p-3 border border-white rounded">
			<h3>Login</h3>
			<form:form action="/users/process/login" method="post" modelAttribute="loginUser">
				    <div class="form-group">
				        <label>Email</label>
				        <form:input path="email" class="form-control" />
				        <form:errors path="email" class="text-danger" />
				    </div>
				    <div class="form-group">
				        <label>Password</label>
				        <form:input path="password" class="form-control" />
				        <form:errors path="password" class="text-danger" />
				    </div>

				    <input type="submit" value="Login" class="btn btn-primary" />
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>