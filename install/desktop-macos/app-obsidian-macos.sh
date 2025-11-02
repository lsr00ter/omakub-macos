#!/bin/zsh

# Install Obsidian note-taking app for macOS
echo "Installing Obsidian..."

source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh

echo "Obsidian installation starting... This may take a few minutes."
install_app_via_brew "obsidian" "--cask" || true

echo "✓ Obsidian installed"
echo "📝 Obsidian is a powerful note-taking app with markdown support"
echo "   Open it from Applications or Spotlight search"