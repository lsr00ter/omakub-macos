# Omakin - Omakub for macOS

This is the macOS adaptation of Omakub - a shell script-based setup tool that transforms a fresh macOS installation into a fully-configured development environment.

## Quick Start

```bash
# Bootstrap installation
zsh <(curl -s https://raw.githubusercontent.com/lsr00ter/omakub-macos/macos/boot-macos.sh)

# Or clone and run locally
rm -rf ~/.local/share/omakub-macos
mkdir -p ~/.local/share
git clone https://github.com/lsr00ter/omakub-macos.git ~/.local/share/omakub-macos >/dev/null
cd omakub-macos
source ~/.local/share/omakub-macos/install-macos.sh
```

### Post-Installation Management

```bash
# Access configuration options
omakin

# Font selection
source ~/.local/share/omakub-macos/bin/omakub-sub-macos/font.sh
```

## Requirements

- macOS 14+ (Sonoma or later)
- Intel or Apple Silicon Mac (Intel Macs fully supported)
- Internet connection
- Administrator privileges

### Architecture Detection

The system automatically detects Mac architecture and configures paths accordingly:

- **Apple Silicon**: Uses `/opt/homebrew`
- **Intel**: Uses `/usr/local`
- **Environment**: `HOMEBREW_PREFIX` and `OMAKUB_ARCH` variables set automatically

## What Gets Installed

### Core Infrastructure

- **Xcode Command Line Tools** - An optional component of Xcode
- **Homebrew** - Package manager for macOS
- **Git** - Version control
- **gum** - Interactive prompts

### Terminal Applications

- **Neovim** - Modern vim-based editor with LazyVim
- **Alacritty** - GPU-accelerated terminal emulator with complete configuration setup (shared settings, pane management, theme integration, font configuration)
- **btop** - System monitor
- **fastfetch** - System information tool

### Desktop Applications

- **Google Chrome** - Web browser
- **Visual Studio Code** - Code editor
- **Optional apps**: 1Password, Spotify, Zoom, Dropbox, Rectangle, Alfred, iTerm2

### Development Tools

- **Programming Languages**: Ruby on Rails, Node.js, Go, PHP, Python, Elixir, Rust, Java
- **Databases**: MySQL, Redis, PostgreSQL (via Docker)
- **Development libraries**: autoconf, pkg-config, openssl, readline, etc.

### macOS Configurations

- Dark mode enabled
- Dock auto-hide and magnification with proper XML plist configuration
- Automatic cleanup of unwanted default dock apps (Messages, Maps, Photos, FaceTime, etc.)
- Fixed font configuration system for proper terminal font rendering
- Finder path bar and status bar
- Improved keyboard repeat rates
- Trackpad tap-to-click
- Screenshot settings

## Architecture

### Entry Points and Flow

1. **`boot-macos.sh`** - Bootstrap entry point that installs Homebrew and clones repo
2. **`install-macos.sh`** - Main orchestrator with `set -e` (exits on any error)
3. **Error handling**: Uses trap to provide retry instructions on failure

### Installation Framework

```text
install/
├── terminal-macos.sh          # Terminal app orchestrator
├── desktop-macos.sh           # Desktop app orchestrator
├── terminal-macos/*.sh        # Individual terminal installers
├── desktop-macos/*.sh         # Individual desktop installers
└── desktop-macos/optional/    # Optional app installers
```

### Configuration Management

- **`configs/`** - Original Ubuntu configuration templates
- **`configs-macos/`** - macOS-adapted configurations with platform-specific paths and settings
- **Key differences**: Homebrew paths, macOS-specific window decorations, font families, system preferences

#### configs-macos Structure

The `configs-macos/` directory contains macOS-optimized configuration files:

```bash
configs-macos/
├── alacritty.toml                    # Main terminal config
├── alacritty/
│   ├── font-size.toml               # macOS-optimized font sizing
│   ├── fonts/                       # Font definitions
│   │   ├── CascadiaMono.toml
│   │   ├── FiraMono.toml
│   │   ├── JetBrainsMono.toml
│   │   └── MesloLGS.toml
│   ├── pane.toml                    # Desktop app window settings
│   └── shared.toml                  # macOS window decorations
├── btop.conf                        # System monitor config
├── fastfetch.jsonc                  # System info with macOS detection
├── inputrc                          # Zsh-compatible readline config
├── neovim/
│   ├── transparency.lua             # Transparent background
│   └── snacks-animated-scrolling-off.lua
├── typora/
│   ├── ia_typora.css               # Light theme
│   └── ia_typora_night.css         # Dark theme
├── vscode.json                      # macOS font stack & paths
├── zellij.kdl                       # Terminal multiplexer
└── zshrc                           # Zsh shell configuration
```

## Development

### Core Utilities

Key functions for development and app installation:

```bash
# From install/terminal-macos/libraries-macos.sh
install_app_via_brew "package-name" "--cask"  # GUI applications
install_app_via_brew "package-name"           # CLI tools
ensure_homebrew()                              # Homebrew setup with arch detection
```

### Adding New Applications

1. **Terminal apps**: Create `install/terminal-macos/app-{name}-macos.sh`
2. **Desktop apps**: Create `install/desktop-macos/app-{name}-macos.sh`
3. **Optional apps**: Create `install/desktop-macos/optional/app-{name}-macos.sh`

### Standard App Installer Template

```bash
#!/bin/zsh
source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh
install_app_via_brew "package-name" "--cask"  # or "" for CLI
# Additional setup steps
echo "✓ App installed"
```

### Platform Differences from Ubuntu

| Aspect | Ubuntu | macOS |
|--------|--------|-------|
| Package Manager | APT | Homebrew |
| Desktop Apps | Flatpak | Homebrew Cask |
| System Config | gsettings | defaults write |
| Shell | Bash | Zsh |

## Known Limitations

1. **Manual Steps Required**: Some applications (like setting default browser) require manual user interaction
2. **No GNOME Equivalent**: Many Ubuntu/GNOME-specific features don't have direct macOS equivalents
3. **Homebrew Dependencies**: Requires Homebrew which may conflict with other package managers
4. **Limited Theme Support**: macOS has fewer theming options compared to Linux desktop environments

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-app`
3. Add your application installer following the existing patterns
4. Test thoroughly on both Intel and Apple Silicon Macs
5. Submit a pull request

## Troubleshooting

### Common Issues

1. **"Command not found: brew"**
   - Solution: The boot script should install Homebrew automatically
   - Manual fix: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

2. **"Permission denied"**
   - Solution: Ensure scripts are executable: `chmod +x script-name.sh`
   - Some operations may require sudo privileges

3. **"App already exists"**
   - Solution: Homebrew will skip already installed packages
   - To reinstall: `brew reinstall package-name`

### Logs and Debugging

Enable verbose output:

```bash
set -x  # Add to script for debugging
brew install --verbose package-name
```

## Configuration File Mapping

### configs-macos vs configs Differences

| File | Key macOS Adaptations |
|------|----------------------|
| **alacritty/shared.toml** | • Architecture-aware zellij path (auto-detects Intel vs Apple Silicon)<br>• Native window decorations `buttonless`<br>• macOS-specific window settings and blur |
| **btop.conf** | • Simplified boolean values (`true`/`false` vs `True`/`False`)<br>• Removed Linux-specific GPU and kernel options |
| **fastfetch.jsonc** | • Mac icon and macOS-specific detection<br>• Proper macOS age calculation using `system_profiler`<br>• Removed Desktop Environment detection |
| **vscode.json** | • macOS font stack with SF Mono fallbacks<br>• Enhanced UI preferences for macOS<br>• Proper font ligatures and line height |
| **zshrc** | • References `omakub-macos/defaults/zsh/rc`<br>• Zsh-specific instead of bash |
| **typora/*.css** | • macOS-specific theme path configurations<br>• Compatible with macOS Typora directory structure |

### Deployment Paths

| Config File | Ubuntu Path | macOS Path |
|-------------|-------------|------------|
| VSCode settings | `~/.config/Code/User/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| Typora themes | `~/.config/Typora/themes/` | `~/Library/Application Support/abnerworks.Typora/themes/` |
| Other configs | `~/.config/[app]/` | `~/.config/[app]/` (same) |

**Migration Complete**: All macOS installation scripts now reference `configs-macos/` with proper platform-specific adaptations.

## References

### macOS Configuration

- **[macOS Defaults](https://macos-defaults.com/)** - Comprehensive database of macOS `defaults` commands and system preferences
  - Documentation for all `defaults write` commands used in this project
  - Browse settings by application (Dock, Finder, Safari, etc.)
  - Understand what each configuration change does to your system

## License

MIT License - see LICENSE file for details.

## Credits

Based on the original [Omakub](https://github.com/basecamp/omakub) by Basecamp, adapted for macOS.

---

# Omakub

Turn a fresh Ubuntu installation into a fully-configured, beautiful, and modern web development system by running a single command. That's the one-line pitch for Omakub. No need to write bespoke configs for every essential tool just to get started or to be up on all the latest command-line tools. Omakub is an opinionated take on what Linux can be at its best.

Watch the introduction video and read more at [omakub.org](https://omakub.org).

## Contributing to the documentation

Please help us improve Omakub's documentation on the [basecamp/omakub-site repository](https://github.com/basecamp/omakub-site).

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, extras, that you can use to adjust, replace or enrich your experience.

[⇒ Browse the omakub extensions.](EXTENSIONS.md)
