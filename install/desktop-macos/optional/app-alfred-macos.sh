#!/bin/zsh

# Install Alfred for macOS
echo "Installing Alfred..."

source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh

# Install Alfred app
install_app_via_brew "alfred" "--cask"

echo "✓ Alfred installed"
echo "🔍 Alfred is your productivity app and launcher for macOS"
echo "   Launch with ⌘+Space (or configure your preferred hotkey)"
echo ""
echo "💡 Setup instructions:"
echo "   1. Open Alfred from Applications"
echo "   2. Grant necessary permissions in System Settings"
echo "   3. Configure hotkey in Alfred Preferences"
echo "   4. Consider upgrading to Alfred Powerpack for workflows"
