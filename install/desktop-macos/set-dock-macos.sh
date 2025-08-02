#!/bin/zsh

# Ensure dockutil is installed
if ! command -v dockutil &> /dev/null; then
    echo "dockutil not found. Please install it first by running: brew install dockutil"
    exit 1
fi

# Favorite apps for dock
apps=(
	"Google Chrome"
	"Alacritty"
	"Visual Studio Code"
	"WhatsApp"
	"Signal"
	"Zoom"
	"Spotify"
	"Steam"
	"Obsidian"
	"1Password"
)

# Add each application to the dock
for app in "${apps[@]}"; do
    # Check for the app in the main Applications folder
    if [ -d "/Applications/$app.app" ]; then
        dockutil --add "/Applications/$app.app" --replacing "$app" --no-restart
        echo "Added $app to the Dock."
    # Check for the app in the user's Applications folder
    elif [ -d "$HOME/Applications/$app.app" ]; then
        dockutil --add "$HOME/Applications/$app.app" --replacing "$app" --no-restart
        echo "Added $app to the Dock."
    else
        echo "Warning: $app not found. Skipping."
    fi
done

# Restart dock to apply changes
killall Dock || true
