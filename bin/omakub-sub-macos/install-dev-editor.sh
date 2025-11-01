#!/bin/zsh

# Source brew helpers
source ~/.local/share/omakub-macos/install/terminal-macos/brew-helpers.sh

EDITORS=(
  "Cursor        AI-powered code editor by Anysphere"
  "Zed           High-performance editor by Zed Industries"
  "Windsurf      AI development environment"
  "RubyMine      JetBrains Ruby/Rails IDE"
  "WebStorm      JetBrains JavaScript/TypeScript IDE"
  "IntelliJ      JetBrains Java IDE"
  "<< Back       "
)

CHOICE=$(gum choose "${EDITORS[@]}" --height 10 --header "Choose development editor to install")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
  # Don't install anything
  echo ""
else
  EDITOR=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]')

  case "$EDITOR" in
  "cursor")
    echo "Installing Cursor..."
    brew_install_cask cursor
    ;;
  "zed")
    echo "Installing Zed..."
    brew_install_cask zed
    ;;
  "windsurf")
    echo "Installing Windsurf..."
    brew_install_cask windsurf
    ;;
  "rubymine")
    echo "Installing RubyMine..."
    brew_install_cask rubymine
    ;;
  "webstorm")
    echo "Installing WebStorm..."
    brew_install_cask webstorm
    ;;
  "intellij")
    echo "Installing IntelliJ IDEA..."
    brew_install_cask intellij-idea
    ;;
  esac

  echo "$EDITOR installation completed!"
fi

source $OMAKUB_PATH/bin/omakub-sub-macos/menu.sh
