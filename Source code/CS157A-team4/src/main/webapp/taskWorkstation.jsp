<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Workstation</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/lucide/0.263.1/lucide.min.css" rel="stylesheet">
    <style>
        /* Add any custom styles here */
        .modal {
            transition: opacity 0.25s ease;
        }
        .modal-active {
            overflow-x: hidden;
            overflow-y: visible !important;
        }
    </style>
</head>
<body class="min-h-screen bg-gray-100">
    <div class="p-8">
        <div class="max-w-4xl mx-auto relative">
            <!-- Fixed Navigation Bar -->
            <div class="fixed top-0 left-0 right-0 bg-white shadow-sm z-50">
                <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex items-center justify-between h-16">
                        <!-- Left side: Back button -->
                        <div class="flex items-center">
                            <a href="myTask.jsp" class="inline-flex items-center px-4 py-2 bg-white border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M19 12H5M12 19l-7-7 7-7"/>
                                </svg>
                                Back to Task List
                            </a>
                        </div>

                        <!-- Center: Title -->
                        <h1 class="text-xl font-bold text-gray-800">Task Manager</h1>

                        <!-- Right side: Timer and Music controls -->
                        <div class="flex items-center space-x-2">
                            <div class="flex items-center space-x-2">
                                <button onclick="toggleTimer()" 
                                        class="inline-flex items-center justify-center px-3 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 text-sm"
                                        id="timerButton">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 24 24" fill="none" 
                                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <circle cx="12" cy="12" r="10"/>
                                        <polyline points="12 6 12 12 16 14"/>
                                    </svg>
                                    Start Timer
                                </button>
                                <span id="timerDisplay" class="font-mono text-sm text-gray-600 hidden"></span>
                            </div>
                            <div class="flex items-center space-x-2">
                                <button id="musicButton" onclick="toggleMusic()" 
                                        class="inline-flex items-center justify-center px-3 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 text-sm">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 24 24" fill="none" 
                                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M9 18V5l12-2v13"/>
                                        <circle cx="6" cy="18" r="3"/>
                                        <circle cx="18" cy="16" r="3"/>
                                    </svg>
                                    Play Music
                                </button>
                                <input type="range" 
                                       min="0" 
                                       max="100" 
                                       value="50" 
                                       class="w-20"
                                       oninput="adjustVolume(this.value)"
                                       title="Volume">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="pt-24 px-8">
                <div class="max-w-4xl mx-auto">
                    <!-- Main Card -->
                    <div class="bg-white rounded-lg shadow-md overflow-hidden">
                        <!-- Card Header -->
                        <div class="p-6 border-b border-gray-200">
                            <div class="flex justify-between items-center">
                                <h2 class="text-xl font-bold text-gray-800">${task.taskName}</h2>
                                <span class="px-3 py-1 rounded-full text-sm 
                                    ${task.status eq 'Completed' ? 'bg-green-100 text-green-800' : 
                                    task.status eq 'Overdue' ? 'bg-red-100 text-red-800' : 
                                    'bg-yellow-100 text-yellow-800'}">
                                    Due: ${task.dueDate}
                                </span>
                            </div>
                        </div>

                        <!-- Card Content -->
                        <div class="p-6 space-y-6">
                            <!-- Task Description -->
                            <div>
                                <h3 class="text-lg font-semibold mb-2">Task Description</h3>
                                <form action="UpdateDescription" method="post" class="space-y-2">
                                    <input type="hidden" name="taskId" value="${task.taskId}">
                                    <textarea name="description" 
                                            class="w-full min-h-[100px] p-3 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                                            >${task.description}</textarea>
                                    <button type="submit" 
                                            class="inline-flex items-center px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/>
                                            <polyline points="17 21 17 13 7 13 7 21"/>
                                            <polyline points="7 3 7 8 15 8"/>
                                        </svg>
                                        Update Description
                                    </button>
                                </form>
                            </div>

                            <!-- Notes Section -->
                            <div>
                                <h3 class="text-lg font-semibold mb-2">Notes</h3>
                                <form action="UpdateNotes" method="post" class="space-y-2">
                                    <input type="hidden" name="taskId" value="${task.taskId}">
                                    <textarea name="quickNote" 
                                            class="w-full min-h-[100px] p-3 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                                            placeholder="Add your notes here...">${task.quickNote}</textarea>
                                    <button type="submit" 
                                            class="inline-flex items-center px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/>
                                            <polyline points="17 21 17 13 7 13 7 21"/>
                                            <polyline points="7 3 7 8 15 8"/>
                                        </svg>
                                        Update Notes
                                    </button>
                                </form>
                            </div>

                            <!-- Resources Section -->
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <h3 class="text-lg font-semibold">Resources</h3>
                                    <button onclick="toggleResourceModal()" 
                                            class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <line x1="12" y1="5" x2="12" y2="19"/>
                                            <line x1="5" y1="12" x2="19" y2="12"/>
                                        </svg>
                                        Add Resource
                                    </button>
                                </div>
                                
                                <!-- Resource List -->
                                <ul class="space-y-2">
                                    <c:forEach var="resource" items="${task.resources}">
                                        <li class="flex justify-between items-center">
                                            <a href="${resource.url}" target="_blank" rel="noopener noreferrer" 
                                            class="flex items-center space-x-2 text-blue-500 hover:underline">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 24 24" fill="none" 
                                                    stroke="currentColor" stroke-width="2">
                                                    <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/>
                                                    <polyline points="15 3 21 3 21 9"/>
                                                    <line x1="10" y1="14" x2="21" y2="3"/>
                                                </svg>
                                                <span>${resource.displayText}</span>
                                            </a>
                                            <form action="ResourceServlet" method="post" class="inline">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="taskId" value="${task.taskId}">
                                                <input type="hidden" name="resourceId" value="${resource.id}">
                                                <button type="submit" class="text-red-500 hover:text-red-700">
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                                        <path d="M18 6L6 18M6 6l12 12"/>
                                                    </svg>
                                                </button>
                                            </form>
                                        </li>
                                    </c:forEach>
                                </ul>
                                
                                <!-- Add Resource Form -->
                                <div id="resourceModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center overflow-y-auto p-4">
                                    <div class="relative bg-white rounded-lg w-full max-w-md my-10">
                                        <!-- Close button at top-right -->
                                        <button type="button" 
                                                onclick="toggleResourceModal()" 
                                                class="absolute top-4 right-4 text-gray-400 hover:text-gray-500">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                            </svg>
                                        </button>

                                        <!-- Modal Content -->
                                        <div class="p-6">
                                            <h3 class="text-lg font-semibold mb-4">Add Resource</h3>
                                            
                                            <!-- Form Content -->
                                            <form action="ResourceServlet" method="post" id="resourceForm" class="space-y-4">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="taskId" value="${task.taskId}">
                                                
                                                <div>
                                                    <label for="url" class="block text-sm font-medium text-gray-700">URL</label>
                                                    <input type="url" id="url" name="url" required
                                                        class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 text-sm"
                                                        placeholder="Enter resource URL"
                                                        oninput="updateDisplayText(this.value)">
                                                </div>
                                                
                                                <div>
                                                    <label for="displayText" class="block text-sm font-medium text-gray-700">
                                                        Display Text (optional)
                                                    </label>
                                                    <input type="text" id="displayText" name="displayText"
                                                        class="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 text-sm"
                                                        placeholder="Enter display text (defaults to URL)">
                                                </div>

                                                <!-- Quick Access Links -->
                                                <div class="mt-6">
                                                    <h4 class="text-sm font-medium text-gray-700 mb-3">Quick Access</h4>
                                                    <div class="grid grid-cols-2 gap-3">
                                                        <!-- Canvas -->
                                                        <button type="button" onclick="setResourceUrl('https://sjsu.instructure.com/', 'Canvas')" 
                                                                class="flex items-center p-3 border rounded-lg hover:bg-gray-50 transition-colors">
                                                            <img src="https://cdn.worldvectorlogo.com/logos/canvas-1.svg" 
                                                                alt="Canvas" 
                                                                class="w-6 h-6 mr-2">
                                                            <span class="text-sm text-gray-600">Canvas</span>
                                                        </button>

                                                        <!-- Cengage -->
                                                        <button type="button" onclick="setResourceUrl('https://www.cengage.com/dashboard/home', 'Cengage')" 
                                                                class="flex items-center p-3 border rounded-lg hover:bg-gray-50 transition-colors">
                                                            <img src="https://logo.clearbit.com/cengage.com" 
                                                                alt="Cengage" 
                                                                class="w-6 h-6 mr-2">
                                                            <span class="text-sm text-gray-600">Cengage</span>
                                                        </button>

                                                        <!-- Gradescope -->
                                                        <button type="button" onclick="setResourceUrl('https://www.gradescope.com/', 'Gradescope')" 
                                                                class="flex items-center p-3 border rounded-lg hover:bg-gray-50 transition-colors">
                                                            <img src="https://logo.clearbit.com/gradescope.com" 
                                                                alt="Gradescope" 
                                                                class="w-6 h-6 mr-2">
                                                            <span class="text-sm text-gray-600">Gradescope</span>
                                                        </button>

                                                        <!-- Quizlet -->
                                                        <button type="button" onclick="setResourceUrl('https://quizlet.com/', 'Quizlet')" 
                                                                class="flex items-center p-3 border rounded-lg hover:bg-gray-50 transition-colors">
                                                            <img src="https://logo.clearbit.com/quizlet.com" 
                                                                alt="Quizlet" 
                                                                class="w-6 h-6 mr-2">
                                                            <span class="text-sm text-gray-600">Quizlet</span>
                                                        </button>

                                                        <!-- Chegg -->
                                                        <button type="button" onclick="setResourceUrl('https://www.chegg.com/', 'Chegg')" 
                                                                class="flex items-center p-3 border rounded-lg hover:bg-gray-50 transition-colors">
                                                            <img src="https://logo.clearbit.com/chegg.com" 
                                                                alt="Chegg" 
                                                                class="w-6 h-6 mr-2">
                                                            <span class="text-sm text-gray-600">Chegg</span>
                                                        </button>

                                                        <!-- WebAssign -->
                                                        <button type="button" onclick="setResourceUrl('https://www.webassign.net/', 'WebAssign')" 
                                                                class="flex items-center p-3 border rounded-lg hover:bg-gray-50 transition-colors">
                                                            <img src="https://logo.clearbit.com/webassign.net" 
                                                                alt="WebAssign" 
                                                                class="w-6 h-6 mr-2">
                                                            <span class="text-sm text-gray-600">WebAssign</span>
                                                        </button>
                                                    </div>
                                                </div>
                                                
                                                <!-- Form Buttons -->
                                                <div class="flex justify-end space-x-3 mt-6">
                                                    <button type="button" onclick="toggleResourceModal()"
                                                            class="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">
                                                        Cancel
                                                    </button>
                                                    <button type="submit"
                                                            class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 text-sm font-medium">
                                                        Add Resource
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Link to the existing course  -->
                            <!-- Course Link Section -->
                            <div>
                                <h3 class="text-lg font-semibold mb-2">Related Course</h3>
                                <div class="space-y-4">
                                    <c:if test="${linkedCourse != null}">
                                        <div class="bg-blue-50 border border-blue-200 rounded-md p-4">
                                            <p class="text-sm text-blue-800">
                                                Currently linked to: ${linkedCourse.courseName}
                                            </p>
                                            <form action="TaskCourseServlet" method="post" class="mt-2">
                                                <input type="hidden" name="action" value="unlink">
                                                <input type="hidden" name="taskId" value="${task.taskId}">
                                                <button type="button" onclick="confirmUnlink(this.form)" 
                                                        class="px-4 py-2 text-sm text-red-600 border border-red-300 rounded-md hover:bg-red-50">
                                                    Unlink Course
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${linkedCourse == null}">
                                        <p class="text-sm text-gray-600">No course linked to this task.</p>
                                        <form action="TaskCourseServlet" method="post">
                                            <input type="hidden" name="action" value="link">
                                            <input type="hidden" name="taskId" value="${task.taskId}">
                                            <div class="flex items-center space-x-4">
                                                <select name="courseId" 
                                                        class="block w-full max-w-xs rounded-md border border-gray-300 py-2 px-3 text-base focus:outline-none focus:ring-2 focus:ring-blue-500 sm:text-sm"
                                                        required>
                                                    <option value="">Select a course</option>
                                                    <c:forEach var="course" items="${availableCourses}">
                                                        <option value="${course.courseId}">${course.courseName}</option>
                                                    </c:forEach>
                                                </select>
                                                <button type="submit" 
                                                        class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 text-sm">
                                                    Link Course
                                                </button>
                                            </div>
                                        </form>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Progress Section -->
                            <div>
                                <h3 class="text-lg font-semibold mb-2">Progress</h3>
                                <form action="UpdateProgress" method="post" class="space-y-4">
                                    <input type="hidden" name="taskId" value="${task.taskId}">
                                    <div class="flex justify-between">
                                        <c:forEach var="value" items="0,25,50,75,100">
                                            <div class="flex items-center space-x-2">
                                                <input type="radio" id="progress${value}" name="progress" value="${value}"
                                                    ${task.progress eq value ? 'checked' : ''} 
                                                    class="form-radio h-4 w-4 text-blue-600">
                                                <label for="progress${value}" class="text-sm text-gray-700">${value}%</label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-2.5">
                                        <div class="bg-blue-600 h-2.5 rounded-full transition-all duration-300 ease-in-out"
                                            style="width: ${task.progress}%"></div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>    
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/timer.js"></script>
    <script src="${pageContext.request.contextPath}/music.js"></script>
    <script>
        function setResourceUrl(url, displayText) {
            document.getElementById('url').value = url;
            document.getElementById('displayText').value = displayText;
        }

        function updateDisplayText(url) {
            const displayTextInput = document.getElementById('displayText');
            if (!displayTextInput.value || displayTextInput.value === displayTextInput.defaultValue) {
                // Extract domain name for display text
                try {
                    const domain = new URL(url).hostname.replace('www.', '');
                    displayTextInput.value = domain.charAt(0).toUpperCase() + domain.slice(1);
                } catch {
                    displayTextInput.value = url;
                }
            }
        }

        function confirmUnlink(form) {
            if (confirm('Are you sure you want to unlink this course from the task?')) {
                form.submit();
            }
        }

        // Progress radio buttons auto-submit
        document.querySelectorAll('input[name="progress"]').forEach(radio => {
            radio.addEventListener('change', function() {
                this.closest('form').submit();
            });
        });

        // Resource Modal
        function toggleResourceModal() {
            const modal = document.getElementById('resourceModal');
            if (modal.classList.contains('hidden')) {
                // Reset form when opening
                document.getElementById('resourceForm').reset();
                modal.classList.remove('hidden');
            } else {
                modal.classList.add('hidden');
            }
        }
    
        function updateDisplayText(url) {
            const displayTextInput = document.getElementById('displayText');
            if (!displayTextInput.value || displayTextInput.value === displayTextInput.defaultValue) {
                displayTextInput.value = url;
            }
        }
    
        // Close modal when clicking outside
        document.getElementById('resourceModal').addEventListener('click', function(event) {
            if (event.target === this) {
                toggleResourceModal();
            }
        });
    
        // Prevent form submission if URL is empty
        document.getElementById('resourceForm').addEventListener('submit', function(event) {
            const urlInput = document.getElementById('url');
            if (!urlInput.value) {
                event.preventDefault();
                alert('Please enter a valid URL');
            }
        });
    </script>
</body>
</html>