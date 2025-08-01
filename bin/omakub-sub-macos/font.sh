#!/bin/zsh

install_font_via_brew() {
	local font_name=$1
	local brew_font_name=$2
	# Map font names to config file names
	local file_name
	case "$font_name" in
		"Cascadia Nerd Font") file_name="CascadiaMono" ;;
		"FiraMono Nerd Font") file_name="FiraMono" ;;
		"JetBrainsMono Nerd Font") file_name="JetBrainsMono" ;;
		"MesloLGS Nerd Font") file_name="MesloLGS" ;;
		*) file_name="${font_name/ Nerd Font/}" ;;
	esac

	# Check if font is already installed using brew list
	if brew list --cask "$brew_font_name" &>/dev/null; then
		echo "Font '$font_name' is already installed."
	else
		echo "Installing '$font_name' via Homebrew..."
		brew install --cask "$brew_font_name"
		clear
		source $OMAKUB_PATH/ascii-macos.sh
		echo "Font '$font_name' installed successfully!"
	fi

	# Update Alacritty font config (same structure as Ubuntu)
	mkdir -p ~/.config/alacritty
	cp "$OMAKUB_PATH/configs-macos/alacritty/fonts/$file_name.toml" ~/.config/alacritty/font.toml 2>/dev/null || {
		echo "Font config not found, using default Alacritty font configuration"
	}

	# Update VSCode font (macOS path is different)
	local vscode_settings="$HOME/Library/Application Support/Code/User/settings.json"
	if [ -f "$vscode_settings" ]; then
		sed -i '' "s/\"editor.fontFamily\": \".*\"/\"editor.fontFamily\": \"$font_name\"/g" "$vscode_settings"
	fi

	echo "Font settings updated for Alacritty and VSCode"
}

if [ "$#" -gt 1 ]; then
	choice=${@[-1]}  # zsh syntax for last argument
else
	choice=$(gum choose "Cascadia Mono" "Fira Mono" "JetBrains Mono" "Meslo" "> Change size" "<< Back" --height 8 --header "Choose your programming font")
fi

case $choice in
"Cascadia Mono")
	install_font_via_brew "Cascadia Nerd Font" "font-cascadia-mono-nf"
	;;
"Fira Mono")
	install_font_via_brew "FiraMono Nerd Font" "font-fira-mono-nerd-font"
	;;
"JetBrains Mono")
	install_font_via_brew "JetBrainsMono Nerd Font" "font-jetbrains-mono-nerd-font"
	;;
"Meslo")
	install_font_via_brew "MesloLGS Nerd Font" "font-meslo-lg-nerd-font"
	;;
"> Change size")
	source $OMAKUB_PATH/bin/omakub-sub-macos/font-size.sh
	exit
	;;
esac

source $OMAKUB_PATH/bin/omakub-sub-macos/menu.sh
