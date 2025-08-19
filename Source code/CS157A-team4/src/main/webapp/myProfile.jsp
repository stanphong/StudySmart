<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>StudySmart - User Profile</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen">
	<jsp:include page="navbar.jsp" />
	<div class="max-w-2xl mx-auto py-8 px-4">
		<!-- Success Message -->
		<c:if test="${param.success != null}">
			<div
				class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded">
				Profile Updated Successfully!</div>
		</c:if>

		<!-- Error Messages -->
		<c:if test="${param.error != null}">
			<div class="mb-4">
				<c:choose>
					<c:when test="${param.error == '1'}">
						<div
							class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
							Please make your username 4 letters or longer!</div>
					</c:when>
					<c:when test="${param.error == '2'}">
						<div
							class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
							Passwords don't match!</div>
					</c:when>
					<c:when test="${param.error == '3'}">
						<div
							class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
							An error occurred while updating your profile.</div>
					</c:when>
				</c:choose>
			</div>
		</c:if>
		<!-- Back Button -->
		<a href="homePage.jsp"
			class="flex items-center text-blue-500 font-bold mb-6"> <svg
				class="h-5 w-5 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none"
				viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round"
					stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg> Back
		</a>

		<div class="bg-white shadow rounded-lg p-6">
			<h1 class="text-2xl font-bold text-blue-600 mb-6">User Profile</h1>

			<c:choose>
				<c:when test="${empty user}">
					<c:redirect url="loginPage.jsp" />
				</c:when>
				<c:otherwise>
					<c:if test="${param.edit == null}">
						<!-- View Mode -->
						<div class="space-y-4">
							<div class="border-b pb-4">
								<c:choose>
									<c:when test="${not empty user.profilePicture}">
										<!-- Show User Profile Picture if it exists -->
										<div class="flex justify-center">
											<img src="${user.profilePicture}" alt="Profile Picture"
												class="w-32 h-32 rounded-full object-cover">
										</div>
									</c:when>
									<c:otherwise>
										<!-- Show Default Profile Picture Icon if no profile picture is uploaded -->
										<div class="flex justify-center items-center">
											<i class="fas fa-user-circle text-9xl text-gray-600 mb-4"></i>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="border-b pb-4">
								<p class="text-gray-600">Username</p>
								<p class="text-gray-900 font-medium">${user.user_id}</p>
							</div>

							<div class="border-b pb-4">
								<p class="text-gray-600">Name</p>
								<p class="text-gray-900 font-medium">${user.name}</p>
							</div>

							<div class="border-b pb-4">
								<p class="text-gray-600">Email</p>
								<p class="text-gray-900 font-medium">${user.email}</p>
							</div>

							<div class="border-b pb-4">
								<p class="text-gray-600">Password</p>
								<div class="flex items-center">
									<p id="passwordText" class="text-gray-900 font-medium">••••••••</p>
									<button onclick="togglePassword()"
										class="ml-2 text-blue-600 hover:text-blue-800">
										<svg id="eyeIcon" xmlns="http://www.w3.org/2000/svg"
											fill="none" viewBox="0 0 24 24" stroke="currentColor"
											class="w-5 h-5">
																						<path stroke-linecap="round"
												stroke-linejoin="round" stroke-width="2"
												d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
																						<path stroke-linecap="round"
												stroke-linejoin="round" stroke-width="2"
												d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
																				</svg>
									</button>
									<input type="hidden" id="actualPassword"
										value="${user.password}">
								</div>
							</div>

							<div class="flex flex-col space-y-3 pt-4">
								<form action="UpdateProfile" method="get">
									<button type="submit" name="edit" value="true"
										class="w-full py-2 px-4 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
										Edit Profile</button>
								</form>

								<form action="ULogout" method="post">
									<button type="submit"
										class="w-full py-2 px-4 bg-red-600 text-white rounded-md hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
										Logout</button>
								</form>
							</div>
						</div>
					</c:if>

					<c:if test="${param.edit != null}">
						<!-- Edit Mode -->
						<form action="UpdateProfile" method="post"
							enctype="multipart/form-data" class="space-y-6">
							<div>
								<label for="profilePicture"
									class="block text-sm font-medium text-gray-700">Profile
									Picture</label> <input type="file" id="profilePicture"
									name="profilePicture" accept="image/*"
									class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 focus:border-blue-500 focus:ring-blue-500">
							</div>

							<!-- Other fields for name, email, etc. -->
							<div>
								<label for="name"
									class="block text-sm font-medium text-gray-700">Name</label> <input
									type="text" id="name" name="name" value="${user.name}"
									placeholder="Enter your name"
									class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 focus:border-blue-500 focus:ring-blue-500">
							</div>

							<div>
								<label for="email"
									class="block text-sm font-medium text-gray-700">Email</label> <input
									type="email" id="email" name="email" value="${user.email}"
									placeholder="Enter your email"
									class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 focus:border-blue-500 focus:ring-blue-500">
							</div>

							<div>
								<label for="password"
									class="block text-sm font-medium text-gray-700">New
									Password</label> <input type="password" id="password" name="password"
									placeholder="Enter new password (leave blank to keep current)"
									class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 focus:border-blue-500 focus:ring-blue-500">
							</div>

							<div>
								<label for="passwordConfirm"
									class="block text-sm font-medium text-gray-700">Confirm
									New Password</label> <input type="password" id="passwordConfirm"
									name="passwordConfirm" placeholder="Confirm new password"
									class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 focus:border-blue-500 focus:ring-blue-500">
							</div>

							<div class="flex justify-between pt-4">
								<button type="submit"
									class="inline-flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
									Save Changes</button>
								<a href="myProfile.jsp"
									class="inline-flex justify-center py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
									Cancel </a>
							</div>
						</form>
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<script>
				let passwordVisible = false;
				
				function togglePassword() {
						const passwordText = document.getElementById('passwordText');
						const actualPassword = document.getElementById('actualPassword').value;
						const eyeIcon = document.getElementById('eyeIcon');
						
						if (passwordVisible) {
								passwordText.textContent = '••••••••';
								eyeIcon.innerHTML = `
										<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
										<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
								`;
						} else {
								passwordText.textContent = actualPassword;
								eyeIcon.innerHTML = `
										<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
								`;
						}
						passwordVisible = !passwordVisible;
				}
		</script>
</body>
</html>