<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>StudySmart - Login</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    },
                }
            }
        }
    </script>
</head>
<body
	class="bg-gray-50 min-h-screen flex items-center justify-center font-sans">
	<div class="w-full max-w-md">
		<div class="bg-white shadow-xl rounded-2xl px-8 pt-8 pb-12">
			<div class="text-center mb-8">
				<svg class="mx-auto h-12 w-auto text-blue-600" fill="none"
					viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round"
						stroke-width="2"
						d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                </svg>
				<h2 class="mt-6 text-3xl font-extrabold text-gray-900">Sign in
					to StudySmart</h2>
			</div>
			<% 
			    if (request.getParameter("error") != null) { 
			%>
			<div
				class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative"
				role="alert">
				<strong class="font-bold">Error!</strong> <span
					class="block sm:inline">Invalid username or password.</span>
			</div>
			<% 
			    } 
			    else if (request.getParameter("registered") != null) { 
			%>
			<div
				class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative"
				role="alert">
				<strong class="font-bold">Success!</strong> <span
					class="block sm:inline">You have successfully created an
					account.</span>
			</div>
			<% 
			    } 
			%>
			<form class="space-y-6" action="ULogin" method="post">
				<div>
					<label for="username"
						class="block text-sm font-medium text-gray-700"> Username
					</label>
					<div class="mt-1">
						<input id="username" name="username" type="text" required
							class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
					</div>
				</div>

				<div>
					<label for="password"
						class="block text-sm font-medium text-gray-700"> Password
					</label>
					<div class="mt-1">
						<input id="password" name="password" type="password" required
							class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
					</div>
				</div>

				<div>
					<button type="submit"
						class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
						Sign in</button>
				</div>
			</form>
		</div>
		<p class="mt-8 text-center text-sm text-gray-600">
			Don't have an account? <a href="userRegister.jsp"
				class="font-medium text-blue-600 hover:text-blue-500"> Create
				one now </a>
		</p>
	</div>
</body>
</html>

