#!/bin/zsh

# Install Tailscale for macOS
echo "Installing Tailscale..."

source ~/.local/share/omakub-macos/install/terminal-macos/libraries-macos.sh

# Install Tailscale app
install_app_via_brew "tailscale"

echo "✓ Tailscale installed"
echo "🔗 Tailscale is your secure network mesh VPN"
echo "   Launch from Applications or menu bar"
echo ""
echo "💡 Setup instructions:"
echo "   1. Open Tailscale from Applications"
echo "   2. Sign in with your Tailscale account"
echo "   3. Grant necessary permissions in System Settings"
echo "   4. Connect to your tailnet to access devices securely"
echo "   5. Use 'tailscale' command in terminal for advanced operations"
