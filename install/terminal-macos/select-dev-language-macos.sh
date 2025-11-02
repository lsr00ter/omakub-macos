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
        echo "📦 Installing Ruby (this may take 5-10 minutes)..."

        # Detect if running under Rosetta 2
        CURRENT_ARCH=$(uname -m)
        ROSETTA_CHECK=$(sysctl -n sysctl.proc_translated 2>/dev/null || echo 0)

        if [[ "$CURRENT_ARCH" == "x86_64" ]] && [[ "$ROSETTA_CHECK" == "1" ]]; then
          echo "⚠️  Detected Rosetta 2 environment. Switching to ARM64 for Ruby compilation..."
          MISE_CMD="arch -arm64 mise"
        else
          MISE_CMD="mise"
        fi

        # Set up build environment for Ruby compilation on macOS
        export HOMEBREW_PREFIX=$(/opt/homebrew/bin/brew --prefix 2>/dev/null || /usr/local/bin/brew --prefix)
        export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/openssl@3/lib/pkgconfig:$HOMEBREW_PREFIX/opt/readline/lib/pkgconfig:$HOMEBREW_PREFIX/opt/libyaml/lib/pkgconfig:$HOMEBREW_PREFIX/opt/libffi/lib/pkgconfig:$PKG_CONFIG_PATH"
        export LDFLAGS="-L$HOMEBREW_PREFIX/opt/openssl@3/lib -L$HOMEBREW_PREFIX/opt/readline/lib -L$HOMEBREW_PREFIX/opt/libyaml/lib -L$HOMEBREW_PREFIX/opt/libffi/lib"
        export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openssl@3/include -I$HOMEBREW_PREFIX/opt/readline/include -I$HOMEBREW_PREFIX/opt/libyaml/include -I$HOMEBREW_PREFIX/opt/libffi/include"
        export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$HOMEBREW_PREFIX/opt/openssl@3 --with-readline-dir=$HOMEBREW_PREFIX/opt/readline --with-libyaml-dir=$HOMEBREW_PREFIX/opt/libyaml"

        if $MISE_CMD use --global ruby@latest; then
          $MISE_CMD settings add idiomatic_version_file_enable_tools ruby
          echo "💎 Installing Rails..."
          if $MISE_CMD x ruby -- gem install rails --no-document; then
            echo "✓ Ruby on Rails installed successfully"
          else
            echo "⚠️  Warning: Rails installation failed, but Ruby is installed"
          fi
        else
          echo "❌ Error: Ruby installation failed"
          echo "💡 Architecture: $CURRENT_ARCH (Rosetta: $ROSETTA_CHECK)"
          echo "💡 Try manually in ARM64 shell: arch -arm64 zsh"
          echo "💡 Then run: mise use --global ruby@latest"
        fi
        ;;
      "Node.js")
        mise use --global node@lts
        ;;
      "Go")
        mise use --global go@latest
        ;;
      "PHP")
        # Source brew helpers
        source ~/.local/share/omakub-macos/install/terminal-macos/brew-helpers.sh
        # Install PHP via Homebrew for macOS
        safe_brew install php composer
        # Install common PHP extensions available on macOS
        safe_brew install php-redis
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
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || {
          echo "✗ Failed to install Rust"
        }
        source "$HOME/.cargo/env" 2>/dev/null || true
        ;;
      "Java")
        mise use --global java@latest
        ;;
      esac
    fi
  done
fi
