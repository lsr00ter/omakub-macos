#!/bin/zsh

echo "Installing desktop applications and configuring macOS..."

# Run desktop installers
for installer in ~/.local/share/omakub-macos/install/desktop-macos/*.sh; do source "$installer"; done
