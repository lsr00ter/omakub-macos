#!/bin/zsh

# Install clipboard manager for macOS
# Alternative to wl-clipboard (Wayland clipboard utility)
echo "Installing clipboard manager..."

source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh

install_app_via_brew "maccy" "--cask" || true

echo "✓ Maccy clipboard manager installed"
echo "📋 Maccy provides clipboard history and management"
echo "   Access via menu bar or use ⌘⇧C to open clipboard history"
echo ""
echo "💡 Built-in macOS clipboard shortcuts:"
echo "   - ⌘C : Copy"
echo "   - ⌘V : Paste"
echo "   - ⌘⌥V : Paste and match style"