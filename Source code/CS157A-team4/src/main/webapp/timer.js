document.addEventListener('DOMContentLoaded', function() {
  let isTimerRunning = false;
  let timerStartTime = null;
  let timerInterval = null;

  // Make toggleTimer global
  window.toggleTimer = function() {
      isTimerRunning = !isTimerRunning;
      const button = document.getElementById('timerButton');
      const timerDisplay = document.getElementById('timerDisplay');
      
      if (isTimerRunning) {
          // Start timer
          timerStartTime = new Date();
          startTimer();
          updateButtonToStop(button);
          timerDisplay.classList.remove('hidden');
          showNotification('Timer started');
      } else {
          // Stop timer and record session
          stopAndRecordSession();
          updateButtonToStart(button);
          timerDisplay.classList.add('hidden');
          showNotification('Timer stopped - Session recorded');
      }
  }

  function startTimer() {
      const timerDisplay = document.getElementById('timerDisplay');
      
      // Update timer display every second
      timerInterval = setInterval(() => {
          const currentTime = new Date();
          const elapsedTime = new Date(currentTime - timerStartTime);
          const hours = String(elapsedTime.getUTCHours()).padStart(2, '0');
          const minutes = String(elapsedTime.getUTCMinutes()).padStart(2, '0');
          const seconds = String(elapsedTime.getUTCSeconds()).padStart(2, '0');
          timerDisplay.textContent = `${hours}:${minutes}:${seconds}`;
      }, 1000);
  }

  function stopAndRecordSession() {
    // Clear interval and get end time
    clearInterval(timerInterval);
    const endTime = new Date();
    
    // Format times for backend
    const startTimeStr = timerStartTime.toTimeString().split(' ')[0];
    const endTimeStr = endTime.toTimeString().split(' ')[0];
    const dateRecordedStr = endTime.toISOString().split('T')[0]; // Get the date in YYYY-MM-DD format
    const taskId = document.querySelector('input[name="taskId"]').value;
    
    // Send study session data to backend
    fetch('RecordStudySession', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `startTime=${encodeURIComponent(startTimeStr)}&endTime=${encodeURIComponent(endTimeStr)}&dateRecorded=${encodeURIComponent(dateRecordedStr)}&taskId=${encodeURIComponent(taskId)}`
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('Error recording study session', true);
    });
  }

  function updateButtonToStop(button) {
      button.classList.replace('bg-blue-500', 'bg-red-500');
      button.classList.replace('hover:bg-blue-600', 'hover:bg-red-600');
      button.innerHTML = `
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 24 24" fill="none" 
               stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="10"/>
              <polyline points="12 6 12 12 16 14"/>
          </svg>
          Stop Timer`;
  }

  function updateButtonToStart(button) {
      button.classList.replace('bg-red-500', 'bg-blue-500');
      button.classList.replace('hover:bg-red-600', 'hover:bg-blue-600');
      button.innerHTML = `
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 24 24" fill="none" 
               stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="10"/>
              <polyline points="12 6 12 12 16 14"/>
          </svg>
          Start Timer`;
  }

  function showNotification(message, isError = false) {
      const notification = document.createElement('div');
      notification.className = `fixed bottom-4 left-4 py-2 px-4 rounded-md ${isError ? 'bg-red-500' : 'bg-blue-500'} text-white text-sm transition-opacity duration-300`;
      notification.textContent = message;
      document.body.appendChild(notification);
      
      // Fade out and remove after 3 seconds
      setTimeout(() => {
          notification.classList.add('opacity-0');
          setTimeout(() => notification.remove(), 300);
      }, 3000);
  }
});