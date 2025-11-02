#!/bin/zsh

# Install Xournal++ for macOS (PDF annotation and note-taking)
echo "Installing Xournal++..."

source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh

install_app_via_brew "xournal-plus-plus" "--cask" || true

echo "✓ Xournal++ installed"
echo "📝 Xournal++ is perfect for PDF annotation and handwritten notes"