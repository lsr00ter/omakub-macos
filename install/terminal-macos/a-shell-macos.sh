#!/bin/zsh

# Set up zsh as the default shell and configure it
echo "Setting up zsh shell configuration for Omakub macOS..."

# Backup existing .zshrc if it exists
if [[ -f "$HOME/.zshrc" ]]; then
    BACKUP_TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="$HOME/.zshrc.backup.$BACKUP_TIMESTAMP"
    echo "Backing up existing .zshrc to .zshrc.backup.$BACKUP_TIMESTAMP"
    cp "$HOME/.zshrc" "$BACKUP_FILE"
fi

# Create new .zshrc that sources Omakub configuration
cat > "$HOME/.zshrc" << 'EOF'
# Omakub macOS zsh configuration
# Source the main Omakub zsh configuration
if [[ -f ~/.local/share/omakub-macos/defaults/zsh/rc ]]; then
    source ~/.local/share/omakub-macos/defaults/zsh/rc
fi

# Local customizations (add your personal config here)
# This file is not overwritten by Omakub updates
EOF

# Set zsh as default shell if it isn't already
if [[ "$SHELL" != "$(which zsh)" ]]; then
    echo "Setting zsh as default shell..."
    # macOS way to change shell (try without sudo first, then with sudo if needed)
    if ! chsh -s "$(which zsh)" 2>/dev/null; then
        sudo chsh -s "$(which zsh)" "$USER"
    fi
    echo "⚠️  You'll need to restart your terminal or run 'exec zsh' to use the new shell"
fi

echo "✅ Zsh shell configuration completed!"
echo "📁 Configuration files: ~/.local/share/omakub-macos/defaults/zsh/"
echo "🔄 Main config file: ~/.zshrc"
echo ""
echo "To apply changes immediately, run: source ~/.zshrc"
