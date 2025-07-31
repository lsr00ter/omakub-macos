#!/bin/zsh

THEME_NAMES=("Tokyo Night" "Catppuccin" "Nord" "Everforest" "Gruvbox" "Kanagawa" "Rose Pine")
THEME=$(gum choose "${THEME_NAMES[@]}" "<< Back" --header "Choose your theme" --height 10 | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

if [ -n "$THEME" ] && [ "$THEME" != "<<-back" ]; then
  # Create necessary config directories
  mkdir -p ~/.config/alacritty ~/.config/zellij/themes ~/.config/nvim/lua/plugins ~/.config/btop/themes

  # Copy Alacritty theme (macOS uses same config structure)
  cp $OMAKUB_PATH/themes/$THEME/alacritty.toml ~/.config/alacritty/theme.toml

  # Copy Zellij theme (terminal multiplexer - same across platforms)
  cp $OMAKUB_PATH/themes/$THEME/zellij.kdl ~/.config/zellij/themes/$THEME.kdl
  sed -i '' "s/theme \".*\"/theme \"$THEME\"/g" ~/.config/zellij/config.kdl 2>/dev/null || true

  # Copy Neovim theme (same across platforms)
  cp $OMAKUB_PATH/themes/$THEME/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

  # Copy btop theme (system monitor - same config)
  if [ -f "$OMAKUB_PATH/themes/$THEME/btop.theme" ]; then
    cp $OMAKUB_PATH/themes/$THEME/btop.theme ~/.config/btop/themes/$THEME.theme
    sed -i '' "s/color_theme = \".*\"/color_theme = \"$THEME\"/g" ~/.config/btop/btop.conf
  else
    sed -i '' "s/color_theme = \".*\"/color_theme = \"Default\"/g" ~/.config/btop/btop.conf
  fi

  # Apply macOS-specific theme scripts
  if [ -f "$OMAKUB_PATH/themes/$THEME/macos.sh" ]; then
    source $OMAKUB_PATH/themes/$THEME/macos.sh
  fi

  # Apply VSCode theme (macOS-specific version)
  source $OMAKUB_PATH/themes/$THEME/vscode-macos.sh

  # Forgo setting the Chrome theme until we might find a less disruptive way of doing it.
  # Having to quit Chrome, and all Chrome-based apps, is too much of an inposition.
  # source $OMAKUB_PATH/themes/$THEME/chrome.sh
  # Note: Ubuntu-specific scripts are intentionally skipped on macOS:
  # - gnome.sh (GNOME desktop theming - not applicable)
  # - tophat.sh (Linux-specific GNOME extension - not applicable)
  # - chrome.sh (uses Linux-specific approaches - not applicable)
  # - vscode.sh (uses Linux paths - replaced with vscode-macos.sh)
fi

source $OMAKUB_PATH/bin/omakub-sub-macos/menu.sh
