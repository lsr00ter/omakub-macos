#!/bin/zsh

# Homebrew Helper Functions for Apple Silicon
# Ensures brew commands run under the correct architecture to avoid Rosetta 2 issues
# Reference: https://github.com/orgs/Homebrew/discussions/2434

# Prevent duplicate loading
if [[ -n "$BREW_HELPERS_LOADED" ]]; then
    return 0
fi
export BREW_HELPERS_LOADED=1

# Detect system architecture
function get_arch() {
    uname -m
}

# Get the correct Homebrew prefix based on architecture
function get_brew_prefix() {
    if [[ $(get_arch) == "arm64" ]]; then
        echo "/opt/homebrew"
    else
        echo "/usr/local"
    fi
}

# Execute brew command with correct architecture prefix
# This prevents Rosetta 2 issues on Apple Silicon
function safe_brew() {
    local brew_prefix=$(get_brew_prefix)

    # On Apple Silicon, ensure we're running in native ARM64 mode
    if [[ $(get_arch) == "arm64" ]]; then
        # Check if we're accidentally running under Rosetta
        if [[ -n "$ROSETTA_ACTIVE" ]] || sysctl -n sysctl.proc_translated 2>/dev/null | grep -q 1; then
            echo "⚠️  Warning: Running under Rosetta 2. Forcing ARM64 mode..."
            arch -arm64 "$brew_prefix/bin/brew" "$@"
        else
            "$brew_prefix/bin/brew" "$@"
        fi
    else
        # Intel Mac - run normally
        "$brew_prefix/bin/brew" "$@"
    fi
}

# Clean up incorrect portable-ruby installation if detected
# This fixes the "Cannot install under Rosetta 2" error
function cleanup_rosetta_ruby() {
    local brew_prefix=$(get_brew_prefix)
    local ruby_path="$brew_prefix/Library/Homebrew/vendor/portable-ruby"

    if [[ -d "$ruby_path" ]] && [[ $(get_arch) == "arm64" ]]; then
        # Check if ruby binary is x86_64 when it should be arm64
        local ruby_bin="$ruby_path/current/bin/ruby"
        if [[ -f "$ruby_bin" ]]; then
            local ruby_arch=$(file "$ruby_bin" | grep -o "x86_64\|arm64" | head -1)
            if [[ "$ruby_arch" == "x86_64" ]]; then
                echo "⚠️  Detected x86_64 portable-ruby on ARM64 system"
                echo "🔧 Removing incorrect portable-ruby installation..."
                rm -rf "$ruby_path"
                echo "✓ Cleanup complete. Running brew update to reinstall correct version..."
                safe_brew update
            fi
        fi
    fi
}

# Initialize Homebrew environment
function init_brew_env() {
    local brew_prefix=$(get_brew_prefix)

    if [[ -f "$brew_prefix/bin/brew" ]]; then
        eval "$($brew_prefix/bin/brew shellenv)"
    fi
}

# Install Homebrew if not present
function ensure_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "📦 Homebrew not found. Installing..."

        # On Apple Silicon, ensure installation happens in ARM64 mode
        if [[ $(get_arch) == "arm64" ]]; then
            arch -arm64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        else
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

        init_brew_env
    fi

    # Check and fix any Rosetta 2 portable-ruby issues
    cleanup_rosetta_ruby

    echo "📦 Updating Homebrew..."
    safe_brew update
}

# Install package via Homebrew with proper architecture handling
function brew_install() {
    ensure_homebrew
    safe_brew install "$@"
}

# Install cask via Homebrew with proper architecture handling
function brew_install_cask() {
    ensure_homebrew
    safe_brew install --cask "$@"
}

# Export functions for use in other scripts
export -f get_arch
export -f get_brew_prefix
export -f safe_brew
export -f cleanup_rosetta_ruby
export -f init_brew_env
export -f ensure_homebrew
export -f brew_install
export -f brew_install_cask
