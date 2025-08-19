<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Tasks</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
.modal {
	transition: opacity 0.25s ease;
}

body.modal-active {
	overflow-x: hidden;
	overflow-y: visible !important;
}
</style>
</head>
<body class="bg-gray-100 font-sans">
	<!-- Include the navigation bar -->
	<jsp:include page="navbar.jsp" />
	<div class="container mx-auto p-6">

		<!-- Back Button -->
		<a href="homePage.jsp"
			class="flex items-center text-blue-500 font-bold mb-6"> <svg
				class="h-5 w-5 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none"
				viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round"
					stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg> Back
		</a>

		<h1 class="text-3xl font-bold text-gray-800 mb-6">Manage My Tasks</h1>

		<!-- Button to open modal -->
		<button
			class="modal-open bg-blue-500 text-white font-bold py-2 px-4 rounded mb-6">
			Add New Task</button>

		<!-- New Sorting and Filtering Controls -->
		<div class="flex flex-wrap gap-4 mb-6">
			<div class="flex items-center space-x-2">
				<label class="text-gray-700 font-semibold">Sort by:</label> <select
					id="sortBy" onchange="refreshWithFilters()"
					class="border rounded-md px-3 py-1 focus:outline-none focus:ring-2 focus:ring-blue-500">
					<option value="" ${currentSortBy == null ? 'selected' : ''}>None</option>
					<option value="dueDate"
						${currentSortBy == 'dueDate' ? 'selected' : ''}>Due Date</option>
					<option value="priority"
						${currentSortBy == 'priority' ? 'selected' : ''}>Priority</option>
				</select>
			</div>
			<div class="flex items-center space-x-2">
				<label class="text-gray-700 font-semibold">Filter Status:</label> <select
					id="filterStatus" onchange="refreshWithFilters()"
					class="border rounded-md px-3 py-1 focus:outline-none focus:ring-2 focus:ring-blue-500">
					<option value="all"
						${currentFilterStatus == null || currentFilterStatus == 'all' ? 'selected' : ''}>All</option>
					<option value="Pending"
						${currentFilterStatus == 'Pending' ? 'selected' : ''}>Pending</option>
					<option value="Completed"
						${currentFilterStatus == 'Completed' ? 'selected' : ''}>Completed</option>
					<option value="Overdue"
						${currentFilterStatus == 'Overdue' ? 'selected' : ''}>Overdue</option>
				</select>
			</div>
		</div>

		<!-- Modal -->
		<div
			class="modal opacity-0 pointer-events-none fixed w-full h-full top-0 left-0 flex items-center justify-center p-4">
			<div
				class="modal-overlay absolute w-full h-full bg-gray-900 opacity-50"></div>

			<div
				class="modal-container bg-white w-full sm:w-11/12 md:w-3/4 lg:w-1/2 xl:w-2/5 mx-auto rounded shadow-lg z-50 overflow-y-auto max-h-[90vh]">
				<div class="modal-content py-4 text-left px-4 sm:px-6">
					<!-- Modal Header -->
					<div class="flex justify-between items-center pb-3">
						<p class="text-xl sm:text-2xl font-bold">Add New Task</p>
						<div class="modal-close cursor-pointer z-50">
							<svg class="fill-current text-black"
								xmlns="http://www.w3.org/2000/svg" width="18" height="18"
								viewBox="0 0 18 18">
                                <path
									d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"></path>
                            </svg>
						</div>
					</div>

					<!-- Modal Body -->
					<form action="UAddTask" method="post" class="space-y-4"
						onsubmit="setTimeout(refreshTasks, 1000)">
						<div>
							<label for="taskName"
								class="block text-gray-700 text-sm font-bold mb-2">Task
								Name:</label> <input type="text" id="taskName" name="taskName" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
								placeholder="Enter task name">
						</div>

						<div>
							<label for="description"
								class="block text-gray-700 text-sm font-bold mb-2">Description:</label>
							<textarea id="description" name="description" rows="4" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
								placeholder="Enter task description"></textarea>
						</div>

						<div>
							<label for="dueDate"
								class="block text-gray-700 text-sm font-bold mb-2">Due
								Date:</label> <input type="date" id="dueDate" name="dueDate" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						</div>

						<div>
							<label for="priority"
								class="block text-gray-700 text-sm font-bold mb-2">Priority:</label>
							<select id="priority" name="priority" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
								<option value="Low">Low</option>
								<option value="Medium">Medium</option>
								<option value="High">High</option>
							</select>
						</div>

						<div>
							<label for="status"
								class="block text-gray-700 text-sm font-bold mb-2">Status:</label>
							<select id="status" name="status" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
								<option value="Pending">Pending</option>
								<option value="Completed">Completed</option>
								<option value="Overdue">Overdue</option>
							</select>
						</div>

						<div>
							<label for="type"
								class="block text-gray-700 text-sm font-bold mb-2">Type:</label>
							<select id="type" name="type" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
								<option value="Group Task">Group Task</option>
								<option value="Personal Task">Personal Task</option>
								<option value="Exam">Exam</option>
							</select>
						</div>

						<div class="flex justify-end pt-2">
							<button type="submit"
								class="px-4 bg-blue-500 p-3 rounded-lg text-white hover:bg-blue-400">Add
								Task</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- Display User's Tasks -->
		<h2 class="text-2xl font-semibold text-gray-700 mb-4">My Tasks</h2>

		<c:if test="${empty taskList}">
			<p class="text-gray-600">No tasks found. Add a new task to get
				started!</p>
		</c:if>

		<c:if test="${not empty taskList}">
			<div class="overflow-x-auto">
				<table class="min-w-full bg-white shadow-md rounded-lg">
					<thead>
						<tr
							class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
							<th class="py-3 px-6 text-left">Task Name</th>
							<!-- <th class="py-3 px-6 text-left">Description</th> -->
							<th class="py-3 px-6 text-left">Due Date</th>
							<th class="py-3 px-6 text-left">Priority</th>
							<th class="py-3 px-6 text-left">Status</th>
							<th class="py-3 px-6 text-left">Type</th>
							<th class="py-3 px-6 text-left">Actions</th>
						</tr>
					</thead>
					<tbody id="taskTableBody" class="text-gray-600 text-sm font-light">
						<c:forEach var="task" items="${taskList}">
							<tr
								class="border-b border-gray-200 transition-colors duration-200 ease-in-out cursor-pointer
                                        ${task.type eq 'Group Task' ? 'bg-blue-50/50 hover:bg-blue-100/50' : 
                                        task.type eq 'Personal Task' ? 'bg-red-50/50 hover:bg-red-100/50' : 
                                        'bg-purple-50/50 hover:bg-purple-100/50'}"
								onclick="navigateToWorkstation('${task.taskId}')"
								data-due-date="${task.dueDate}" data-priority="${task.priority}"
								data-status="${task.status}">
								<td class="py-3 px-6 text-left whitespace-nowrap">
									<div class="flex items-center">
										<c:choose>
											<c:when test="${task.type eq 'Group Task'}">
												<svg xmlns="http://www.w3.org/2000/svg"
													class="h-5 w-5 mr-2 text-blue-500" fill="none"
													viewBox="0 0 24 24" stroke="currentColor">
                                                    <path
														stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2"
														d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                                                </svg>
											</c:when>
											<c:when test="${task.type eq 'Personal Task'}">
												<svg xmlns="http://www.w3.org/2000/svg"
													class="h-5 w-5 mr-2 text-red-500" fill="none"
													viewBox="0 0 24 24" stroke="currentColor">
                                                    <path
														stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2"
														d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                </svg>
											</c:when>
											<c:otherwise>
												<svg xmlns="http://www.w3.org/2000/svg"
													class="h-5 w-5 mr-2 text-purple-500" fill="none"
													viewBox="0 0 24 24" stroke="currentColor">
                                                    <path
														stroke-linecap="round" stroke-linejoin="round"
														stroke-width="2"
														d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                                </svg>
											</c:otherwise>
										</c:choose>
										<span class="font-medium">${task.taskName}</span>
									</div>
								</td>
								<!-- <td class="py-3 px-6 text-left whitespace-nowrap">${task.description}</td> -->
								<td class="py-3 px-6 text-left">${task.dueDate}</td>
								<td class="py-3 px-6 text-left"><span
									class="px-2 py-1 rounded-full text-xs 
                                         ${task.priority eq 'High' ? 'bg-red-200 text-red-800' : 
                                           task.priority eq 'Medium' ? 'bg-yellow-200 text-yellow-800' : 
                                           'bg-green-200 text-green-800'}">
										${task.priority} </span></td>
								<td class="py-3 px-6 text-left"><span
									class="px-2 py-1 rounded-full text-xs 
                                         ${task.status eq 'Completed' ? 'bg-green-200 text-green-800' : 
                                           task.status eq 'Overdue' ? 'bg-red-200 text-red-800' : 
                                           'bg-yellow-200 text-yellow-800'}">
										${task.status} </span></td>
								<td class="py-3 px-6 text-left"><span
									class="font-medium ${task.type eq 'Group Task' ? 'text-blue-600' : 
                                                              task.type eq 'Personal Task' ? 'text-red-600' : 
                                                              'text-purple-600'}">
										${task.type} </span></td>
								<td class="py-3 px-6 text-left">
									<button onclick="handleDeleteClick(event, '${task.taskId}')"
										class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded transition-colors duration-200 ease-in-out">
										Finish</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
	</div>

	<script>
        var openmodal = document.querySelectorAll('.modal-open')
        for (var i = 0; i < openmodal.length; i++) {
          openmodal[i].addEventListener('click', function(event){
            event.preventDefault()
            toggleModal()
          })
        }
        
        const overlay = document.querySelector('.modal-overlay')
        overlay.addEventListener('click', toggleModal)
        
        var closemodal = document.querySelectorAll('.modal-close')
        for (var i = 0; i < closemodal.length; i++) {
          closemodal[i].addEventListener('click', toggleModal)
        }
        
        document.onkeydown = function(evt) {
          evt = evt || window.event
          var isEscape = false
          if ("key" in evt) {
            isEscape = (evt.key === "Escape" || evt.key === "Esc")
          } else {
            isEscape = (evt.keyCode === 27)
          }
          if (isEscape && document.body.classList.contains('modal-active')) {
            toggleModal()
          }
        };
        
        function toggleModal () {
          const body = document.querySelector('body')
          const modal = document.querySelector('.modal')
          modal.classList.toggle('opacity-0')
          modal.classList.toggle('pointer-events-none')
          body.classList.toggle('modal-active')
        }

        function refreshTasks() {
            window.location.href = 'UViewTask';
        }
    
        // Call refreshTasks when the page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Only refresh if we haven't just added a task
            if (!window.location.href.includes('UViewTask')) {
                refreshTasks();
            }
        });
    
        function handleDeleteClick(event, taskId) {
            // Stop the event from bubbling up to the row
            event.stopPropagation();
            
            if (confirm('Are you sure you want to delete this task?')) {
                // Create a form
                const form = document.createElement('form');
                form.method = 'post';
                form.action = 'UDeleteTask';
        
                // Add taskId input
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'taskId';
                input.value = taskId;
                form.appendChild(input);
        
                // Add the form to the document and submit it
                document.body.appendChild(form);
                form.submit();
        
                // Refresh tasks after 1 second
                setTimeout(refreshTasks, 1000);
            }
        }
        
        // Function to navigate to task workstation
        function navigateToWorkstation(taskId) {
            window.location.href = 'UWorkStation?taskId=${taskId}' + taskId;
        }

        function refreshWithFilters() {
            const sortBy = document.getElementById('sortBy').value;
            const filterStatus = document.getElementById('filterStatus').value;

            
            // Construct URL with parameters
            let url = 'UViewTask?';
            if (sortBy !== 'none') {
                url += 'sortBy=' + sortBy + '&';
            }
            if (filterStatus !== 'all') {
                url += 'filterStatus=' + filterStatus + '&';
            }
            
            // Remove trailing '&' or '?' if present
            url = url.replace(/[&?]$/, '');
            
            window.location.href = url;
        }
        
    </script>
</body>
</html>