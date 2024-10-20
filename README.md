# Omakub macOS

**On working**

A macOS-specific ripoff of DHH's [Omakub](https://github.com/basecamp/omakub/tree/master) for setting a system-wide look and feel.

**Note:** This is a WIP. It doesn't install any apps, and assumes you're using iTerm and Neovim.

### Features

- Set dark mode based on the chosen theme
- Set the wallpaper based on the chosen theme
- Set the iTerm theme based on the chosen theme
- Set the Neovim theme based on the chosen theme

### Installation

Clone this repo to your local machine:
```sh
git clone omakub-macos ~/.config/omakub
```
If you want to put it somewhere else, be sure to update the `$OMAKUB_DIR` variable in the `omakub` script.

**iTerm**: Since iTerm doesn't offer a good way to import color presets from the command line, you'll have to manually import them in the GUI yourself. The color presets are located in the `themes/iterm` directory of this repo.

### Usage

Symlink the `omakub` script to somewhere in your $PATH:
```sh
ln -s ~/.config/omakub /usr/local/bin/omakub # or some other directory in your $PATH
```
Run it:
```sh
omakub
```
