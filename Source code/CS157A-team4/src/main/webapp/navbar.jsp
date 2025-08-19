<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav class="bg-blue-600 p-4 shadow-md">
	<div class="container mx-auto flex justify-between items-center">
		<!-- Left side - Logo/Home text -->
		<div class="flex items-center">
			<svg class="h-8 w-8 text-white mr-2" fill="none" viewBox="0 0 24 24"
				stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round"
					stroke-width="2"
					d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
            </svg>
			<a
				href='<%= request.getServletPath().equals("/mainPage.jsp") ? "mainPage.jsp" : "homePage.jsp" %>'
				class="text-white font-bold text-xl hover:text-blue-200">StudySmart</a>
		</div>

		<!-- Center - Navigation links -->
		<% if (session.getAttribute("user") != null) { %>
		<div class="flex items-center space-x-4">
			<a href="myCourses.jsp" class="text-white hover:text-blue-200">Courses</a>
			<a href="myTask.jsp" class="text-white hover:text-blue-200">Tasks</a>
			<a href="myStudySessions.jsp" class="text-white hover:text-blue-200">Study
				Sessions</a> <a href="myExtracurriculars.jsp"
				class="text-white hover:text-blue-200">Extracurriculars</a>
		</div>
		<% } else if (request.getServletPath().equals("/mainPage.jsp")) { %>
		<div class="flex items-center space-x-4">
			<a href="#features" class="text-white hover:text-blue-200">Features</a>
			<a href="#about" class="text-white hover:text-blue-200">About</a> <a
				href="#contact" class="text-white hover:text-blue-200">Contact</a>
		</div>
		<% } %>

		<!-- Right side - Profile/Logout or Login/Register -->
		<div class="flex items-center space-x-4">
			<% if (session.getAttribute("user") != null) { %>
			<a href="myProfile.jsp" class="text-white hover:text-blue-200">Profile</a>
			<form action="ULogout" method="post" class="inline-block">
				<button type="submit"
					class="text-white hover:text-blue-200 focus:outline-none">
					Logout</button>
			</form>
			<% } else { %>
			<a href="loginPage.jsp"
				class="px-4 py-2 bg-white text-blue-600 rounded-md hover:bg-blue-50 transition duration-300">Login</a>
			<a href="userRegister.jsp"
				class="px-4 py-2 bg-transparent text-white border border-white rounded-md hover:bg-blue-700 transition duration-300">Register</a>
			<% } %>
		</div>
	</div>
</nav>