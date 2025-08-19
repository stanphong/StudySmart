document.addEventListener('DOMContentLoaded', function() {
  let isMusicPlaying = false;
  let audioPlayer = new Audio();

  const tracks = [
      {
          url: 'https://cdn.pixabay.com/audio/2024/09/29/audio_b199a1d692.mp3',
          title: 'Lofi Study'
      },
      // Add more tracks here, can be local mp3 or online mp3 for music
  ];

  let currentTrackIndex = 0;

  // Initialize audio player
  audioPlayer.volume = 0.5; // Set default volume
  audioPlayer.src = tracks[currentTrackIndex].url;

  // Add event listener for when a track ends
  audioPlayer.addEventListener('ended', function() {
      playNextTrack();
  });

  window.toggleMusic = function() {
      const button = document.getElementById('musicButton');
      
      if (!isMusicPlaying) {
          // Start playing music
          audioPlayer.play()
              .then(() => {
                  isMusicPlaying = true;
                  updateButtonToStop(button);
                  showMusicNotification(`Now playing: ${tracks[currentTrackIndex].title}`);
              })
              .catch(error => {
                  console.error('Error playing music:', error);
                  showMusicNotification('Error playing music', true);
              });
      } else {
          // Stop music
          audioPlayer.pause();
          audioPlayer.currentTime = 0;
          isMusicPlaying = false;
          updateButtonToStart(button);
          showMusicNotification('Music stopped');
      }
  }

  function playNextTrack() {
      currentTrackIndex = (currentTrackIndex + 1) % tracks.length;
      audioPlayer.src = tracks[currentTrackIndex].url;
      if (isMusicPlaying) {
          audioPlayer.play();
          showMusicNotification(`Now playing: ${tracks[currentTrackIndex].title}`);
      }
  }

  // Add volume control
  window.adjustVolume = function(value) {
      audioPlayer.volume = value / 100;
  }

  function updateButtonToStop(button) {
      button.classList.replace('bg-blue-500', 'bg-red-500');
      button.classList.replace('hover:bg-blue-600', 'hover:bg-red-600');
      button.innerHTML = `
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 24 24" fill="none" 
               stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M9 18V5l12-2v13"/>
              <circle cx="6" cy="18" r="3"/>
              <circle cx="18" cy="16" r="3"/>
          </svg>
          Stop Music`;
  }

  function updateButtonToStart(button) {
      button.classList.replace('bg-red-500', 'bg-blue-500');
      button.classList.replace('hover:bg-red-600', 'hover:bg-blue-600');
      button.innerHTML = `
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 24 24" fill="none" 
               stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M9 18V5l12-2v13"/>
              <circle cx="6" cy="18" r="3"/>
              <circle cx="18" cy="16" r="3"/>
          </svg>
          Play Music`;
  }

  function showMusicNotification(message, isError = false) {
      const notification = document.createElement('div');
      notification.className = `fixed bottom-4 right-4 py-2 px-4 rounded-md ${isError ? 'bg-red-500' : 'bg-blue-500'} text-white text-sm transition-opacity duration-300`;
      notification.textContent = message;
      document.body.appendChild(notification);
      
      setTimeout(() => {
          notification.classList.add('opacity-0');
          setTimeout(() => notification.remove(), 300);
      }, 3000);
  }
});