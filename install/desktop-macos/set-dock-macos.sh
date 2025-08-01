#!/bin/zsh

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
	"Pinta"
	"Obsidian"
	"Activity Monitor"
	"1Password"
	"LocalSend"
)

# Array to hold installed favorite apps
installed_apps=()

# Check if applications are installed and get their paths
for app in "${apps[@]}"; do
    if [ -d "/Applications/$app.app" ]; then
        installed_apps+=("/Applications/$app.app")
    elif [ -d "$HOME/Applications/$app.app" ]; then
        installed_apps+=("$HOME/Applications/$app.app")
    fi
done

# Clear existing dock (remove all apps except Finder and Trash)
defaults write com.apple.dock persistent-apps -array

# Add Finder back to dock (it's removed by the above command)
# defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Library/CoreServices/Finder.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

# Add each installed app to the dock
for app_path in "${installed_apps[@]}"; do
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app_path</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

# Restart dock to apply changes
killall Dock
