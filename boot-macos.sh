#!/bin/zsh

set -e

ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
                    for macOS
'

echo -e "$ascii_art"
echo "=> Omakub for macOS - Designed for macOS 14+ (Sonoma) installations!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

# Download and source brew helpers to handle architecture issues
curl -fsSL https://raw.githubusercontent.com/lsr00ter/omakub-macos/macos/install/terminal-macos/brew-helpers.sh -o /tmp/brew-helpers.sh
source /tmp/brew-helpers.sh

# Ensure Homebrew is installed with correct architecture
ensure_homebrew

# Install git using safe_brew wrapper
safe_brew install git >/dev/null

echo "Cloning Omakub for macOS..."
rm -rf ~/.local/share/omakub-macos
mkdir -p ~/.local/share
git clone https://github.com/lsr00ter/omakub-macos.git --depth=1 ~/.local/share/omakub-macos >/dev/null

echo "Installation starting..."
source ~/.local/share/omakub-macos/install-macos.sh
