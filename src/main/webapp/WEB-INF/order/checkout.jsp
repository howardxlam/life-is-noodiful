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

<title>Checkout</title>
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
        <h2 class="text-light">Checkout</h2>
        <table class="table mt-4 text-white bg-dark border">
            <thead>
                <tr>
                    <th class="col col-1 text-center">#</th>
                    <th class="col col-4">Item</th>
                    <th class="col col-2">Price</th>
                    <th class="col col-2"></th>
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
                        <td>
                            <form action="/orders/removeFromBag" method="post">
                            	
    							<input type="hidden" name="foodId" value="${item.id}">
    							<input type="hidden" name="locationId" value="${locationId}" />
    							<div class="form-group d-flex">
       								 <input type="number" name="quantity" value="${item.quantity}" min="0" class="form-control quantity">
    							<button type="submit" class="btn btn-primary">Update</button>
   								 </div>
							</form>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                	<td colspan=2><a href="/orders/new" class="btn btn-primary">Order More</a></td>
        			<td colspan=2><h3 class="text-light text-right">Total Price: <fmt:formatNumber value="${total}" type="currency"/></h3></td>
        			<td></td>
        		</tr>
            </tbody>
        </table>
        
		<div class="text-light col col-6 bg-dark border border-white p-3 mb-5">     
   			<form:form action="/orders/checkout" method="post" modelAttribute="creditCard">
    		<h3 class="text-light">Payment Details</h3>
    		<div class="bg-danger text-white border border-white p-3 my-2">
    			<h6>DO NOT USE YOUR REAL CREDIT CARD</h6>
    			<h6><a href="https://www.creditcardvalidator.org/generator" class="text-white">Generate a fake credit card number</a></h6>
    		</div>
    		<div class="form-group">
        		<div class="d-flex">
        			<label for="cardNumber">Card Number</label>
        			<form:errors path="cardNumber" class="text-danger ml-3" />
        		</div>
        		<form:input path="cardNumber" class="form-control"  />
    		</div>
    		<div class="form-group">
    			<div class="d-flex">
        			<label for="expirationDate">Expiration Date</label>
        			<form:errors path="expirationDate" class="text-danger ml-3" />
        		</div>
        		<form:input path="expirationDate" class="form-control"  />
    		</div>
    		<div class="form-group">
    			<div class="d-flex">
        			<label for="cvc">CVC</label>
        			<form:errors path="cvc" class="text-danger ml-3" />
        		</div>
        		<form:input path="cvc" class="form-control col col-3"  />
    		</div>
    		
    		<input type="hidden" name="locationId" value="${locationId}" />
    		<button type="submit" class="btn btn-primary">Pay</button>
			</form:form>

        
        
        
        
        
    </div>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="/javascript/app.js"></script>
</body>
</html>