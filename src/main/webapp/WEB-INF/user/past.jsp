<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<title>Past Orders</title>
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

	<div class="container text-secondary">

		<h1 class="text-light mb-3">Past Orders</h1>
    		<c:forEach var="order" items="${pastOrders}">
        		<div class="card mb-3">
            		<div class="card-header">
            			<div class="d-flex justify-content-between">
            				<p>Order Date: ${order.createdAt}</p>
            				<p>Order ID: ${order.id}</p>        
            			</div>	   			
            			<div>
            				<p>${order.location.name}, ${order.location.city}</p>
      
            			</div>	   			
            		</div>
            			<div class="card-body">
                			<h5 class="card-title">Order Details</h5>
                			<c:forEach items="${order.orderItems}" var="orderItem">
                				<div class="row">
                					<p class="card-text col col-1">${orderItem.quantity}</p>
                					<p class="card-text col col-7">${orderItem.food.name}</p>
                					<p class="card-text col col-2"><fmt:formatNumber value="${orderItem.food.price}" type="currency"/></p>
                					<p class="card-text col col-2"><fmt:formatNumber value="${orderItem.food.price * orderItem.quantity}" type="currency"/></p>
                				</div>
							</c:forEach>
            			</div>
            			<div class="card-footer">
            				<p class="text-right">Order total: <fmt:formatNumber value="${order.total }" type="currency"/></p>
            			</div>
        			</div>
    </c:forEach>
	
	</div>
	

	
	
	
	
	
	
	
</body>
</html>