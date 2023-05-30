<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<meta charset="ISO-8859-1">
<title>Add an Item</title>
</head>
<body class="bg-dark">


	<div class="navbar m-2">
		<a href="/" class="text-no-decoration"><h3 class="text-light">Restaurant</h3></a>
		<div class="dropdown show">
			<a class="btn dropdown-toggle border border-white" href="#"
				role="button" id="dropdownMenuLink" data-toggle="dropdown"
				aria-haspopup="true" aria-expanded="false">
				<div class="hamburger"></div>
				<div class="hamburger"></div>
				<div class="hamburger"></div>
			</a>

			<div class="dropdown-menu dropdown-menu-right"
				aria-labelledby="dropdownMenuLink">
				<a class="dropdown-item" href="#">Order Online</a> <a
					class="dropdown-item" href="#">Menu</a> <a class="dropdown-item"
					href="#">Locations</a> <a class="dropdown-item" href="/about">About
					Us</a> <a class="dropdown-item" href="#">Something else</a>
			</div>
		</div>
	</div>

	<div class="container text-light">
		<h1 class="mt-4">Create Food Item</h1>

		<div class="row">
			<div class="col">
				<form action="/foods/process/new" class="col col-6" method="post">
					<div class="form-group">
						<label for="name">Name</label> <input type="text" id="name"
							name="name" class="form-control" required>
					</div>

					<div class="form-group">
						<label for="description">Description</label>
						<textarea id="description" name="description" class="form-control"></textarea>
					</div>

					<div class="form-group">
						<label for="price">Price</label> <input type="number" id="price"
							name="price" min="0" step="0.01" class="form-control" required>
					</div>

					<div class="form-group">
						<label for="category">Category</label> <input type="text"
							id="category" name="category" class="form-control" required>
					</div>

					<div class="form-group">
						<label for="image">Image URL</label> <input type="text" id="image"
							name="image" class="form-control" required>
					</div>

					<div class="form-group">
						<label for="ingredients">Ingredients</label>
						<textarea id="ingredients" name="ingredients" class="form-control"></textarea>
					</div>

					<div class="form-group">
						<div class="form-check">
							<input type="checkbox" id="available" name="available"
								class="form-check-input" value="true"> <label
								for="available" class="form-check-label">Available</label>
						</div>
					</div>

					<div class="form-group">
						<div class="form-check">
							<input type="checkbox" id="vegetarian" name="vegetarian"
								class="form-check-input"> <label for="vegetarian"
								class="form-check-label">Vegetarian</label>
						</div>
						<div class="form-check">
							<input type="checkbox" id="vegan" name="vegan"
								class="form-check-input"> <label for="vegan"
								class="form-check-label">Vegan</label>
						</div>
						<div class="form-check">
							<input type="checkbox" id="glutenFree" name="glutenFree"
								class="form-check-input"> <label for="glutenFree"
								class="form-check-label">Gluten-free</label>
						</div>
						<div class="form-check">
							<input type="checkbox" id="noPeanuts" name="noPeanuts"
								class="form-check-input"> <label for="noPeanuts"
								class="form-check-label">No Peanuts</label>
						</div>
					</div>

					<button type="submit" class="btn btn-primary">Create</button>
				</form>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-KyZXEAg3QhqLMpG8r+6+qD1IrqBjzx6TIo4KP8ATD9c3+qZg4NLgS6kUztk27g2N"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"
		integrity="sha384-pzjw6VHRKz5jbz8b8Vv2v4PA8FyYv4N9rpaAz8+QyG3p8CC7ABWSvoX83bZ4bT+q"
		crossorigin="anonymous"></script>


</body>
</html>