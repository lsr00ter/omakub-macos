#!/bin/zsh
source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh
# Alacritty is a GPU-powered and highly extensible terminal. See https://alacritty.org/

install_app_via_brew "alacritty" "--cask"
xattr -rd com.apple.quarantine /Applications/Alacritty.app

# Set up Alacritty configuration
mkdir -p ~/.config/alacritty
cp ~/.local/share/omakub-macos/configs-macos/alacritty.toml ~/.config/alacritty/alacritty.toml
cp ~/.local/share/omakub-macos/configs-macos/alacritty/shared.toml ~/.config/alacritty/shared.toml
cp ~/.local/share/omakub-macos/configs-macos/alacritty/pane.toml ~/.config/alacritty/pane.toml
cp ~/.local/share/omakub-macos/configs-macos/alacritty/btop.toml ~/.config/alacritty/btop.toml
cp ~/.local/share/omakub-macos/themes/tokyo-night/alacritty.toml ~/.config/alacritty/theme.toml
cp ~/.local/share/omakub-macos/configs-macos/alacritty/fonts/CascadiaMono.toml ~/.config/alacritty/font.toml
cp ~/.local/share/omakub-macos/configs-macos/alacritty/font-size.toml ~/.config/alacritty/font-size.toml

# Migrate config format if needed
alacritty migrate 2>/dev/null || true
alacritty migrate -c ~/.config/alacritty/pane.toml 2>/dev/null || true
alacritty migrate -c ~/.config/alacritty/btop.toml 2>/dev/null || true

echo "✓ Alacritty installed"
