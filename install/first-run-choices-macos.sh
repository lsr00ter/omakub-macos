#!/bin/zsh

# macOS-specific optional desktop apps
OPTIONAL_APPS=("1password" "Alfred" "ASDControl" "Audacity" "Brave" "Cursor" "Doom-Emacs" "Dropbox" "GIMP" "iTerm2" "Minecraft" "OBS-Studio" "Parallels" "Rectangle" "RetroArch" "RubyMine" "Signal" "Spotify" "Steam" "Tailscale" "VirtualBox" "Windows" "Windsurf" "Zed" "Zoom")
DEFAULT_OPTIONAL_APPS='1password,Spotify,Rectangle'
export OMAKUB_FIRST_RUN_OPTIONAL_APPS=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --selected $DEFAULT_OPTIONAL_APPS --height 20 --header "Select optional macOS desktop apps")

# macOS-specific optional terminal apps
OPTIONAL_TERMINAL_APPS=("Ollama")
DEFAULT_OPTIONAL_TERMINAL_APPS=''
export OMAKUB_FIRST_RUN_OPTIONAL_TERMINAL_APPS=$(gum choose "${OPTIONAL_TERMINAL_APPS[@]}" --no-limit --selected $DEFAULT_OPTIONAL_TERMINAL_APPS --height 5 --header "Select optional terminal apps")

# Programming languages (same as Ubuntu)
AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
SELECTED_LANGUAGES="Ruby on Rails","Node.js"
export OMAKUB_FIRST_RUN_LANGUAGES=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")

# Databases (same as Ubuntu, will run in Docker)
AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
SELECTED_DBS="MySQL"
export OMAKUB_FIRST_RUN_DBS=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --selected "$SELECTED_DBS" --height 5 --header "Select databases (runs in Docker)")

# macOS-specific terminal choice
TERMINAL_CHOICES=("Alacritty" "iTerm2" "Terminal.app")
DEFAULT_TERMINAL="Alacritty"
export OMAKUB_TERMINAL_CHOICE=$(gum choose "${TERMINAL_CHOICES[@]}" --selected "$DEFAULT_TERMINAL" --height 4 --header "Select your preferred terminal")

echo "Configuration choices saved:"
echo "Optional desktop apps: $OMAKUB_FIRST_RUN_OPTIONAL_APPS"
echo "Optional terminal apps: $OMAKUB_FIRST_RUN_OPTIONAL_TERMINAL_APPS"
echo "Languages: $OMAKUB_FIRST_RUN_LANGUAGES"
echo "Databases: $OMAKUB_FIRST_RUN_DBS"
echo "Terminal: $OMAKUB_TERMINAL_CHOICE"
