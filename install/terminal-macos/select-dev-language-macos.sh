#!/bin/zsh

# Install default programming languages for macOS
if [[ -v OMAKUB_FIRST_RUN_LANGUAGES ]]; then
  languages=$OMAKUB_FIRST_RUN_LANGUAGES
else
  AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
  languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --height 10 --header "Select programming languages")
fi

if [[ -n "$languages" ]]; then
  # Convert to array using zsh parameter expansion
  local language_array=("${(@f)languages}")

  for language in "${language_array[@]}"; do
    # Skip empty lines and trim whitespace
    language=$(echo "$language" | xargs)
    if [[ -n "$language" ]]; then
      case $language in
      "Ruby on Rails")
        mise use --global ruby@latest
        mise settings add idiomatic_version_file_enable_tools ruby
        mise x ruby -- gem install rails --no-document
        ;;
      "Node.js")
        mise use --global node@lts
        ;;
      "Go")
        mise use --global go@latest
        ;;
      "PHP")
        # Install PHP via Homebrew for macOS
        brew install php composer
        # Install common PHP extensions available on macOS
        brew install php-redis
        echo "✓ PHP and Composer installed via Homebrew"
        echo "💡 Additional extensions may need manual installation"
        ;;
      "Python")
        mise use --global python@latest
        ;;
      "Elixir")
        mise use --global erlang@latest
        mise use --global elixir@latest
        mise x elixir -- mix local.hex --force
        ;;
      "Rust")
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        ;;
      "Java")
        mise use --global java@latest
        ;;
      esac
    fi
  done
fi
