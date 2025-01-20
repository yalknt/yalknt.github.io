// script.js

window.addEventListener("load", function() {
    // Select the loading screen element
    const loadingScreen = document.getElementById("loading-screen");
    if (loadingScreen) {
        // Fade out the loading screen over 0.5s for a smooth transition
        loadingScreen.style.transition = "opacity 0.5s ease";
        loadingScreen.style.opacity = "0";

        // Remove the loading screen from the DOM after the fade-out
        setTimeout(() => {
            loadingScreen.remove();
        }, 500); // 500ms matches the transition duration
    }
});

// script.js

// Toggle dark mode on button click
function toggleDarkMode() {
    const body = document.body;
    const isDarkMode = body.classList.toggle("dark-mode");

    // Save user preference to localStorage
    localStorage.setItem("darkMode", isDarkMode ? "enabled" : "disabled");

    // Update button text
    document.getElementById("dark-mode-toggle").textContent = isDarkMode ? "☀️" : "🌙";
}

// Load user preference for dark mode on page load
window.addEventListener("load", () => {
    const darkModePreference = localStorage.getItem("darkMode");
    if (darkModePreference === "enabled") {
        document.body.classList.add("dark-mode");
        document.getElementById("dark-mode-toggle").textContent = "☀️";
    } else {
        document.body.classList.add("light-mode");
    }
});

