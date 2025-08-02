#!/bin/zsh

# Install iTerm2 for macOS
echo "Installing iTerm2..."

source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh

# Install iTerm2 app
install_app_via_brew "iterm2" "--cask"

echo "✓ iTerm2 installed"
echo "💻 iTerm2 is a powerful terminal replacement for macOS"
echo "   Launch from Applications or ⌘+Space → iTerm"
echo ""
echo "💡 Setup instructions:"
echo "   1. Open iTerm2 from Applications"
echo "   2. Configure your preferred color scheme and fonts"
echo "   3. Set up profiles for different environments"
echo "   4. Enable shell integration for enhanced features"
echo "   5. Consider importing your dotfiles and shell configuration"
