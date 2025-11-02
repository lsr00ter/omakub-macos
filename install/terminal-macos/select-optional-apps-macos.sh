#!/bin/zsh

if [[ -v OMAKUB_FIRST_RUN_OPTIONAL_TERMINAL_APPS ]]; then
	apps=$OMAKUB_FIRST_RUN_OPTIONAL_TERMINAL_APPS

	if [[ -n "$apps" ]]; then
		# Convert newline-separated string to array using zsh parameter expansion
		local app_array=("${(@f)apps}")

		for app in "${app_array[@]}"; do
			# Skip empty lines and trim whitespace
			app=$(echo "$app" | xargs)
			if [[ -n "$app" ]]; then
				echo "Installing optional terminal app: $app"
				source "$OMAKUB_PATH/install/terminal-macos/optional/app-${app:l}-macos.sh"
			fi
		done
	fi
fi
