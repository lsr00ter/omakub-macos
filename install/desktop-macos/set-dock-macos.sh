#!/bin/zsh

# Ensure dockutil is installed
if ! command -v dockutil &> /dev/null; then
    echo "Warning: dockutil not found. Skipping dock configuration."
    echo "You can install it manually with: brew install dockutil"
    return 0
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
        dockutil --add "/Applications/$app.app" --replacing "$app" --no-restart || true
        echo "Added $app to the Dock."
    # Check for the app in the user's Applications folder
    elif [ -d "$HOME/Applications/$app.app" ]; then
        dockutil --add "$HOME/Applications/$app.app" --replacing "$app" --no-restart || true
        echo "Added $app to the Dock."
    else
        echo "Warning: $app not found. Skipping."
    fi
done

# Restart dock to apply changes
killall Dock || true
