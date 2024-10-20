# OMAKUB_THEME_COLOR="red"
# OMAKUB_THEME_BACKGROUND="rose-pine/background.jpg"
# source $OMAKUB_PATH/themes/set-gnome-theme.sh
# gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

DARK_MODE="true"
ITERM_THEME="rose-pine-dawn"
# OMAKUB_THEME_BACKGROUND="rose-pine/background.jpg"
WALLPAPER="rose-pine/background.jpg"
NVIM_BACKGROUND="dark"

# set iterm profile
if [[ $TERM_PROGRAM == "iTerm.app" ]] || [[ -n $ITERM_SESSION_ID ]]; then
  osascript -e "
  tell application \"iTerm\"
    tell every window
      tell every tab
        tell every session
          set color preset to \"$ITERM_THEME\"
        end tell
      end tell
    end tell
  end tell"
fi

# set dark mode
if [ "$DARK_MODE" = "true" ]; then
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
else
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'
fi

# set wallpaper
osascript -e "tell application \"Finder\"
  set desktop picture to POSIX file \"$WALLPAPER\"
end tell"

# set alacritty theme if it's installed
if command -v alacritty &>/dev/null; then
  cp "$OMAKUB_PATH/themes/rose-pine/alacritty.toml" ~/.config/alacritty/theme.toml
  touch ~/.config/alacritty/alacritty.toml
fi

# set neovim theme
cp "$OMAKUB_PATH/themes/rose-pine/neovim.lua" ~/.config/nvim/lua/plugins/theme.lua
for servername in $(nvr --serverlist); do
  nvr --servername "$servername" --remote-send ":colorscheme $THEME | set background=$NVIM_BACKGROUND<CR>"
done
