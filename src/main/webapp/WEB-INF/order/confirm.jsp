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
<link rel="stylesheet"
	href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<title>Order Confirmation</title>
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
		<div class="row">
			<div class="col col-6">
				<div class="table mt-4 text-white bg-dark border p-2 text-center">
					<h4 class="py-3">Order Confirmed!</h4>
					<h4 class="mb-5">Thank you for your order, ${user.firstName }!</h4>
					<h5>Estimated ready time: </h5>
					<h5>20 - 25 minutes</h5>
					<p>at</p>
					<h5>${location.name }</h5>
					<p>${location.address }</p>
					<p>${location.city }</p>
				</div>
			</div>
			
			<div class="col col-6">
			    <table class="table mt-4 text-white bg-dark border">
        		<thead>
        			<tr>
        				<th colspan=4><h4>Order Receipt</h4></th>
        			<tr>
           			<tr>
             			<th class="col col-1"></th>
             			<th class="col col-6">Item</th>
         				<th class="col col-2">Price/each</th>
             			<th class="col col-3"></th>
            		</tr>
        		</thead>
        		<tbody>
            		<c:forEach items="${bagItems}" var="item">
                		<tr>
              				<td class="text-center">${item.quantity}</td>
                   			<td>${item.name}</td>
                   			<td><fmt:formatNumber value="${item.price}" type="currency"/></td>
                   			<td><fmt:formatNumber value="${item.price * item.quantity}" type="currency"/></td>
                		</tr>
            			</c:forEach>
            			<tr>
            				<td colspan=4 class="text-right">Total Price: <fmt:formatNumber value="${total}" type="currency"/></td>
            			</tr>
            			<tr>
            				<td colspan=4 class="text-right">Payment: ${lastFourDigits}</td>
            			</tr>	
        			</tbody>
    			</table>
			
			</div>
	
		</div>
    
    
  

    
    </div>
</body>
</html>