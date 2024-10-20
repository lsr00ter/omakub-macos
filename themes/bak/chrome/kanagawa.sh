# Kanagawa
cd "$HOME/Library/Application Support/Google/Chrome/Default" || exit 0

jq '.extensions.theme += {"id": "user_color_theme_id", "system_theme": 0}' Preferences >tmp.json && mv tmp.json Preferences
jq '.browser.theme.color_scheme = 2 | .browser.theme.color_variant = 2 | .browser.theme.user_color = -16774145' Preferences >tmp.json && mv tmp.json Preferences
jq '.ntp += {"custom_background_dict":{"background_url": "https://github.com/bweave/omakub-macos/blob/main/backgrounds/kanagawa.jpg?raw=true"}}' Preferences >tmp.json && mv tmp.json Preferences
cd ~ || exit 0
