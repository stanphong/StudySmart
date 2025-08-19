<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Study Sessions</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/feather-icons/dist/feather.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
</head>
<body class="bg-gray-100 font-sans">
	<jsp:include page="navbar.jsp" />

	<div class="container mx-auto p-6">
		<h1 class="text-3xl font-bold text-gray-800 mb-6">My Study
			Sessions</h1>

		<!-- Week Navigation -->
		<div class="flex justify-between items-center mb-6">
			<button onclick="navigateWeek(-1)"
				class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
				Previous Week</button>
			<div class="text-lg font-semibold">${weekStart}to ${weekEnd}</div>
			<button onclick="navigateWeek(1)"
				class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
				Next Week</button>
		</div>

		<!-- Chart Container -->
		<div class="bg-white shadow-md rounded-lg p-6 mb-6">
			<div class="h-[400px] w-full">
				<canvas id="studyChart"></canvas>
			</div>
		</div>

		<!-- Statistics Cards -->
		<div class="grid grid-cols-1 md:grid-cols-3 gap-6">
			<div class="bg-white rounded-lg shadow-md p-6">
				<h3 class="text-lg font-semibold text-gray-700 mb-2">Total
					Hours</h3>
				<p class="text-3xl font-bold text-blue-500" id="totalHours">0</p>
			</div>
			<div class="bg-white rounded-lg shadow-md p-6">
				<h3 class="text-lg font-semibold text-gray-700 mb-2">Average
					Hours/Day</h3>
				<p class="text-3xl font-bold text-green-500" id="avgHours">0</p>
			</div>
			<div class="bg-white rounded-lg shadow-md p-6">
				<h3 class="text-lg font-semibold text-gray-700 mb-2">Most
					Productive Day</h3>
				<p class="text-3xl font-bold text-purple-500" id="bestDay">-</p>
			</div>
		</div>
	</div>

	<script>
			function refreshTasks() {
				window.location.href = 'StudyStats';
			}

			// Call refreshTasks when the page loads
			document.addEventListener('DOMContentLoaded', function() {
					// Only refresh if we haven't just added a task
					if (!window.location.href.includes('StudyStats')) {
							refreshTasks();
					}
			});

        let chart = null;
        const studyData = JSON.parse('${studyDataJson}');
				let currentWeek = parseInt('${currentWeek}') || 0;

        function formatDate(dateStr) {
					try {
							const [year, month, day] = dateStr.split('-');
							const date = new Date(year, parseInt(month) - 1, day);
							return date.toLocaleDateString('en-US', {
									weekday: 'short',
									month: 'short',
									day: 'numeric'
							});
					} catch (e) {
							console.error('Error formatting date:', dateStr, e);
							return dateStr;
					}
				}
        function initChart() {
					const ctx = document.getElementById('studyChart').getContext('2d');
					const sortedDates = Object.keys(studyData).sort();
					const labels = sortedDates.map(date => formatDate(date));
					const values = sortedDates.map(date => studyData[date]);
	
					if (chart) {
							chart.destroy();
					}
	
					chart = new Chart(ctx, {
							type: 'bar',
							data: {
									labels: labels,
									datasets: [{
											label: 'Study Hours',
											data: values,
											backgroundColor: 'rgba(59, 130, 246, 0.5)',
											borderColor: 'rgb(59, 130, 246)',
											borderWidth: 1
									}]
							},
							options: {
									responsive: true,
									maintainAspectRatio: false,
									scales: {
											y: {
													beginAtZero: true,
													title: {
															display: true,
															text: 'Hours'
													}
											}
									},
									plugins: {
											legend: {
													display: false
											},
											tooltip: {
													callbacks: {
															label: function(context) {
																	return `${context.raw.toFixed(1)} hours`;
															}
													}
											}
									}
							}
					});
	
					updateStatistics(values, labels);
				}

        function updateStatistics(values, labels) {
					const total = values.reduce((a, b) => a + b, 0);
					document.getElementById('totalHours').textContent = total.toFixed(1);

					const avg = total / 7;
					document.getElementById('avgHours').textContent = avg.toFixed(1);

					const maxIndex = values.indexOf(Math.max(...values));
					document.getElementById('bestDay').textContent = labels[maxIndex] || '-';
				}

				function navigateWeek(offset) {
					currentWeek += parseInt(offset);
					window.location.href = 'StudyStats?week=' + currentWeek;
				}

				// Initialize chart on page load
				document.addEventListener('DOMContentLoaded', initChart);
    </script>
</body>
</html>