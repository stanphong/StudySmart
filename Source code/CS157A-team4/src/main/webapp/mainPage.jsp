<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>StudySmart</title>
<script src="https://cdn.tailwindcss.com?v=3.3.3"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/feather-icons/dist/feather.min.js"></script>
<style>
.animate-fadeIn {
	opacity: 0;
	transition: opacity 0.5s ease-out;
}

.animate-slideInUp {
	opacity: 0;
	transform: translateY(20px);
	transition: opacity 0.5s ease-out, transform 0.5s ease-out;
}

body::after {
	content: "";
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #fff;
	z-index: 9999;
	transition: opacity 0.3s ease-out;
}

body.loaded::after {
	opacity: 0;
	pointer-events: none;
}
dient-to-br from-blue-400 to-indigo-600 text-white py-24">

	      <div class="container mx-auto px-6 text-center">
                <h1 class="text-4xl md:text-6xl font-bold mb-6 animate-slideInUp">Welcome to StudySmart</h1>
                <p class="text-xl mb-10 animate-slideInUp">Your ultimate study companion for academic success!</p>
                <a href="userRegister.jsp" 
                   class="group relative inline-flex items-center justify-center bg-white text-blue-600 px-8 py-3 rounded-md font-semibold 
                          overflow-hidden transition-all duration-300 ease-out hover:text-white transform hover:scale-105 
                          hover:shadow-lg animate-slideInUp">
                    <span class="absolute inset-0 bg-blue-600 transform scale-x-0 group-hover:scale-x-100 transition-transform 
                                 duration-300 ease-out origin-left"></span>
                    <span class="relative flex items-center">
                        Get Started
                        <svg class="w-4 h-4 ml-2 transform translate-x-0 group-hover:translate-x-1 transition-transform duration-300" 
                             fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </span>
                </a>
            </div>
        </section>

        <section id="features" class="py-24 bg-white">
            <div class="container mx-auto px-6">
                <h2 class="text-3xl font-bold text-center text-gray-800 mb-16 animate-slideInUp">Features</h2>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
                    <div class="text-center animate-slideInUp">
                        <i data-feather="calendar" class="mx-auto text-blue-600 mb-6 w-12 h-12"></i>
                        <h3 class="text-xl font-semibold mb-4">Task Organization</h3>
                        <p class="text-gray-600">Efficiently manage your tasks and deadlines</p>
                    </div>
                    <div class="text-center animate-slideInUp">
                        <i data-feather="book-open" class="mx-auto text-blue-600 mb-6 w-12 h-12"></i>
                        <h3 class="text-xl font-semibold mb-4">Course Management</h3>
                        <p class="text-gray-600">Keep track of all your courses in one place</p>
                    </div>
                    <div class="text-center animate-slideInUp">
                        <i data-feather="trending-up" class="mx-auto text-blue-600 mb-6 w-12 h-12"></i>
                        <h3 class="text-xl font-semibold mb-4">Progress Tracking</h3>
                        <p class="text-gray-600">Monitor your academic progress over time</p>
                    </div>
                </div>
            </div>
        </section>

        <section id="about" class="py-24 bg-gray-100">
            <div class="container mx-auto px-6">
                <h2 class="text-3xl font-bold text-center text-gray-800 mb-10 animate-slideInUp">About StudySmart</h2>
                <p class="text-gray-600 text-center max-w-2xl mx-auto animate-slideInUp">
                    StudySmart is designed to help students organize their studying, manage tasks, track courses, and monitor progress. Our goal is to provide a comprehensive tool that facilitates all your academic needs in one convenient platform.
                </p>
            </div>
        </section>

        <section id="contact" class="py-24 bg-white">
            <div class="container mx-auto px-6 text-center">
                <h2 class="text-3xl font-bold text-gray-800 mb-10 animate-slideInUp">Contact Us</h2>
                <p class="text-gray-600 mb-10 animate-slideInUp">Have questions or feedback? We'd love to hear from you!</p>
                <a href="mailto:support@studysmart.com" class="bg-blue-600 text-white px-8 py-3 rounded-md font-semibold hover:bg-blue-700 transition duration-300 transform hover:scale-105 inline-block animate-slideInUp">Get in Touch</a>
            </div>
        </section>
    </main>

    <footer class="bg-gray-800 text-white py-10 animate-fadeIn">
        <div class="container mx-auto px-6 text-center">
            <p>&copy; 2024 StudySmart. All rights reserved.</p>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            feather.replace();
            
            setTimeout(function() {
                document.body.classList.add('loaded');
                
                const animatedElements = document.querySelectorAll('.animate-fadeIn, .animate-slideInUp');
                let delay = 100;
                
                animatedElements.forEach(function(element) {
                    setTimeout(function() {
                        element.style.opacity = '1';
                        if (element.classList.contains('animate-slideInUp')) {
                            element.style.transform = 'translateY(0)';
                        }
                    }, delay);
                    delay += 100;
                });
            }, 300);

            // Smooth scrolling for navigation links
            document.querySelectorAll('a.smooth-scroll').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    e.preventDefault();
                    const targetId = this.getAttribute('href').substring(1);
                    const targetElement = document.getElementById(targetId);
                    if (targetElement) {
                        targetElement.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        });
    </script>
</body>
</html>