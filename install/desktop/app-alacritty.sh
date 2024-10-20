# Alacritty is a GPU-powered and highly extensible terminal. See https://alacritty.org/
# sudo apt install -y alacritty
brew install alacritty --cask
mkdir -p ~/.config/alacritty
cp ~/.config/omakub/configs/alacritty.toml ~/.config/alacritty/alacritty.toml
cp ~/.config/omakub/themes/tokyo-night/alacritty.toml ~/.config/alacritty/theme.toml
cp ~/.config/omakub/configs/alacritty/fonts/CaskaydiaMono.toml ~/.config/alacritty/font.toml
cp ~/.config/omakub/configs/alacritty/font-size.toml ~/.config/alacritty/font-size.toml
