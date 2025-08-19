<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="h-full">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>StudySmart - Home</title>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/feather-icons/dist/feather.min.js"></script>
</head>
<body class="bg-gray-100 font-sans flex flex-col min-h-screen">
	<jsp:include page="navbar.jsp" />

	<main class="flex-grow max-w-6xl mx-auto mt-8 p-6">
		<h2 class="text-3xl font-semibold text-gray-800 mb-6">Welcome
			back, ${homePageData.name}!</h2>

		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
			<a href="myProfile.jsp"
				class="transform transition duration-500 hover:scale-105">
				<div
					class="bg-white rounded-lg shadow-md p-6 flex flex-col items-center">
					<i class="fas fa-user-circle text-5xl text-blue-600 mb-4"></i>
					<h3 class="text-xl font-semibold text-gray-800">My Profile</h3>
					<p class="text-gray-600 mt-2 text-center">View and edit your
						personal information</p>
				</div>
			</a> <a href="myCourses.jsp"
				class="transform transition duration-500 hover:scale-105">
				<div
					class="bg-white rounded-lg shadow-md p-6 flex flex-col items-center">
					<i class="fas fa-book text-5xl text-green-600 mb-4"></i>
					<h3 class="text-xl font-semibold text-gray-800">My Courses</h3>
					<p class="text-gray-600 mt-2 text-center">Manage your enrolled
						courses</p>
				</div>
			</a> <a href="myStudySessions.jsp"
				class="transform transition duration-500 hover:scale-105">
				<div
					class="bg-white rounded-lg shadow-md p-6 flex flex-col items-center">
					<i class="fas fa-clock text-5xl text-purple-600 mb-4"></i>
					<h3 class="text-xl font-semibold text-gray-800">Study Sessions</h3>
					<p class="text-gray-600 mt-2 text-center">Schedule and track
						your study sessions</p>
				</div>
			</a> <a href="myExtracurriculars.jsp"
				class="transform transition duration-500 hover:scale-105">
				<div
					class="bg-white rounded-lg shadow-md p-6 flex flex-col items-center">
					<i class="fas fa-puzzle-piece text-5xl text-yellow-600 mb-4"></i>
					<h3 class="text-xl font-semibold text-gray-800">Extracurriculars</h3>
					<p class="text-gray-600 mt-2 text-center">Manage your
						extracurricular activities</p>
				</div>
			</a> <a href="myTask.jsp"
				class="transform transition duration-500 hover:scale-105">
				<div
					class="bg-white rounded-lg shadow-md p-6 flex flex-col items-center">
					<i class="fas fa-tasks text-5xl text-red-600 mb-4"></i>
					<h3 class="text-xl font-semibold text-gray-800">My Tasks</h3>
					<p class="text-gray-600 mt-2 text-center">Organize and track
						your to-do list</p>
				</div>
			</a>

			<div class="bg-white rounded-lg shadow-md p-6">
				<h3 class="text-xl font-semibold text-gray-800 mb-4">My Stats</h3>
				<ul class="space-y-2">
					<li class="flex justify-between"><span class="text-gray-600">Courses
							Enrolled:</span> <span class="font-semibold">${homePageData.coursesEnrolled}</span>
					</li>
					<li class="flex justify-between"><span class="text-gray-600">Upcoming
							Tasks:</span> <span class="font-semibold">${homePageData.numberOfTasks}</span>
					</li>
					<li class="flex justify-between"><span class="text-gray-600">Study
							Hours This Week:</span> <span class="font-semibold">${weeklyStudyHours}</span>
					</li>
				</ul>
			</div>
		</div>
	</main>

	<footer class="bg-gray-800 text-white py-6 mt-auto">
		<div class="max-w-6xl mx-auto text-center">
			<p>&copy; 2024 StudySmart. All rights reserved.</p>
		</div>
	</footer>

	<script>
    
	    function refreshHome() {
	        window.location.href = 'UViewHome';
	    }

    
	    document.addEventListener('DOMContentLoaded', function() {
	        if (!window.location.href.includes('UViewHome')) {
	            refreshHome();
	        }
	    });

    </script>
</body>
</html>