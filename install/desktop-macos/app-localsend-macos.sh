#!/bin/zsh

# Install LocalSend for macOS
echo "Installing LocalSend..."

source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh

install_app_via_brew "localsend" "--cask" || true

echo "✓ LocalSend installed"
echo "📲 LocalSend allows secure file sharing across devices on local network"