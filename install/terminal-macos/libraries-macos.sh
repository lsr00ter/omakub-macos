#!/bin/zsh

# Source brew helpers for architecture-safe operations
BREW_HELPERS="${BASH_SOURCE[0]%/*}/brew-helpers.sh"
if [[ -f "$BREW_HELPERS" ]]; then
    source "$BREW_HELPERS"
elif [[ -f ~/.local/share/omakub-macos/install/terminal-macos/brew-helpers.sh ]]; then
    source ~/.local/share/omakub-macos/install/terminal-macos/brew-helpers.sh
else
    echo "Error: brew-helpers.sh not found"
    exit 1
fi

function install_app_via_brew() {
    local app_name="$1"
    local cask_flag="$2"

    if [[ "$cask_flag" == "--cask" ]]; then
        echo "Installing $app_name via Homebrew Cask..."
        if brew_install_cask "$app_name"; then
            echo "✓ Successfully installed $app_name"
        else
            echo "✗ Failed to install $app_name"
            return 1
        fi
    else
        echo "Installing $app_name via Homebrew..."
        if brew_install "$app_name"; then
            echo "✓ Successfully installed $app_name"
        else
            echo "✗ Failed to install $app_name"
            return 1
        fi
    fi
}

function install_macos_libraries() {
    ensure_homebrew

    echo "Installing development libraries..."

    # Core build tools (equivalent to build-essential)
    safe_brew install \
        autoconf \
        pkg-config \
        bison \
        llvm \
        cmake \
        make \
        coreutils

    # SSL and crypto libraries
    safe_brew install \
        openssl@3 \
        readline \
        zlib \
        libyaml \
        libffi

    # Database tools and libraries
    safe_brew install \
        sqlite3
        # mysql-client
        # postgresql@16 \
        # redis

    # Image processing libraries (equivalent to libvips, imagemagick)
    safe_brew install \
        vips \
        imagemagick

    # Additional development libraries
    safe_brew install \
        libxml2 \
        libxslt \
        libiconv \
        zstd \
        lz4 \
        xz

    # Compression and archive tools
    safe_brew install \
        gzip \
        bzip2 \
        unzip \
        zip

    # Version control and text processing
    safe_brew install \
        git \
        curl \
        wget \
        jq \
        yq

    # Development utilities
    safe_brew install \
        tree \
        ripgrep \
        fd \
        bat \
        eza \
        fzf \
        zoxide

    # Optional: Install Rust if not present (some tools depend on it)
    if ! command -v rustc &> /dev/null; then
        echo "Installing Rust toolchain..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    fi

    echo "✓ Development libraries installed"
    echo ""
    echo "📝 Note: Some libraries may require additional configuration:"
    echo "   - OpenSSL: export PKG_CONFIG_PATH=\"\$HOMEBREW_PREFIX/opt/openssl@3/lib/pkgconfig\""
    echo "   - readline: export PKG_CONFIG_PATH=\"\$HOMEBREW_PREFIX/opt/readline/lib/pkgconfig:\$PKG_CONFIG_PATH\""
    echo "   - libffi: export PKG_CONFIG_PATH=\"\$HOMEBREW_PREFIX/opt/libffi/lib/pkgconfig:\$PKG_CONFIG_PATH\""
    echo "   - These are already handled in the zsh configuration"
}
