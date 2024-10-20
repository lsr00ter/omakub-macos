# OMAKUB_THEME_COLOR="purple"
# OMAKUB_THEME_BACKGROUND="tokyo-night/background.jpg"
# source $OMAKUB_PATH/themes/set-gnome-theme.sh

DARK_MODE="true"
ITERM_THEME="tokyo-night"
# OMAKUB_THEME_BACKGROUND="tokyo-night/background.jpg"
WALLPAPER="tokyo-night/background.jpg"
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
  cp "$OMAKUB_PATH/themes/tokyo-night/alacritty.toml" ~/.config/alacritty/theme.toml
  touch ~/.config/alacritty/alacritty.toml
fi

# set neovim theme
cp "$OMAKUB_PATH/themes/tokyo-night/neovim.lua" ~/.config/nvim/lua/plugins/theme.lua
for servername in $(nvr --serverlist); do
  nvr --servername "$servername" --remote-send ":colorscheme $THEME | set background=$NVIM_BACKGROUND<CR>"
done

# set vscode theme
# if command -v code &>/dev/null; then
#   code --install-extension "$VSC_EXTENSION" >/dev/null
#   jq --arg vsc_theme "$VSC_THEME" '.["workbench.colorTheme"] = $vsc_theme' ~/Library/Application\ Support/Code/User/settings.json >tmp.json && mv tmp.json ~/Library/Application\ Support/Code/User/settings.json
#   if [ "$THEME" == "rose-pine-dawn" ]; then
#     jq --arg vsc_theme "$VSC_THEME" '.["workbench.preferredLightColorTheme"] = $vsc_theme' ~/Library/Application\ Support/Code/User/settings.json >tmp.json && mv tmp.json ~/Library/Application\ Support/Code/User/settings.json
#   else
#     jq --arg vsc_theme "$VSC_THEME" '.["workbench.preferredDarkColorTheme"] = $vsc_theme' ~/Library/Application\ Support/Code/User/settings.json >tmp.json && mv tmp.json ~/Library/Application\ Support/Code/User/settings.json
#   fi
# fi

# set chrome theme
# if mdfind "kMDItemCFBundleIdentifier == 'com.google.Chrome'" >/dev/null; then
#   if gum confirm "Do you want to update Chrome theme? If yes, Chrome will be restarted!"; then
#     pkill -a -i "Google Chrome"

#     while pgrep -i "Google Chrome" >/dev/null; do
#       sleep 0.1
#     done

#     source "$OMAKUB_PATH/themes/chrome/$THEME.sh"
#     open -a "Google Chrome"
#   fi
# fi
