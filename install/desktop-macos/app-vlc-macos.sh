#!/bin/zsh

# Install VLC media player for macOS
echo "Installing VLC media player..."

source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh

install_app_via_brew "vlc" "--cask" || true

echo "✓ VLC media player installed"