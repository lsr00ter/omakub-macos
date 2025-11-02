#!/bin/zsh

# Uninstall Brave Browser
if command -v brew &> /dev/null; then
    # macOS uninstall
    brew uninstall --cask brave-browser || true
else
    # Linux uninstall
    sudo apt remove --purge -y brave-browser
    sudo rm /etc/apt/sources.list.d/brave-browser-release.list
    sudo rm /usr/share/keyrings/brave-browser-*.gpg
fi
