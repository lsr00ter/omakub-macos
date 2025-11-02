#!/bin/zsh
source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh
# Alacritty is a GPU-powered and highly extensible terminal. See https://alacritty.org/

install_app_via_brew "alacritty" "--cask" || {
    echo "✗ Failed to install Alacritty, skipping configuration"
    return 0
}
xattr -rd com.apple.quarantine /Applications/Alacritty.app 2>/dev/null || true

# Set up Alacritty configuration
mkdir -p ~/.config/alacritty || true
cp ~/.local/share/omakub-macos/configs-macos/alacritty.toml ~/.config/alacritty/alacritty.toml 2>/dev/null || true
cp ~/.local/share/omakub-macos/configs-macos/alacritty/shared.toml ~/.config/alacritty/shared.toml 2>/dev/null || true
cp ~/.local/share/omakub-macos/configs-macos/alacritty/pane.toml ~/.config/alacritty/pane.toml 2>/dev/null || true
cp ~/.local/share/omakub-macos/configs-macos/alacritty/btop.toml ~/.config/alacritty/btop.toml 2>/dev/null || true
cp ~/.local/share/omakub-macos/themes/tokyo-night/alacritty.toml ~/.config/alacritty/theme.toml 2>/dev/null || true
cp ~/.local/share/omakub-macos/configs-macos/alacritty/fonts/CascadiaMono.toml ~/.config/alacritty/font.toml 2>/dev/null || true
cp ~/.local/share/omakub-macos/configs-macos/alacritty/font-size.toml ~/.config/alacritty/font-size.toml 2>/dev/null || true

# Fix zellij path based on architecture
sed -i '' "s|/usr/local/bin/zellij|${HOMEBREW_PREFIX}/bin/zellij|g" ~/.config/alacritty/shared.toml 2>/dev/null || true

# Migrate config format if needed
alacritty migrate 2>/dev/null || true
alacritty migrate -c ~/.config/alacritty/pane.toml 2>/dev/null || true
alacritty migrate -c ~/.config/alacritty/btop.toml 2>/dev/null || true

echo "✓ Alacritty installed"
