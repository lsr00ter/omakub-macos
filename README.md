# Omakub macOS

A macOS-specific ripoff of DHH's [Omakub](https://github.com/basecamp/omakub/tree/master) for setting a system-wide look and feel.

**Note:** This is a WIP. It doesn't install any apps, and assumes you're using iTerm and Neovim.

### Features

- Set dark mode based on the chosen theme
- Set the wallpaper based on the chosen theme
- Set the iTerm theme based on the chosen theme
- Set the Neovim theme based on the chosen theme

### Usage

Symlink the `omakub` script to somewhere in your $PATH:
```sh
ln -s /path/to/omakub-macos /usr/local/bin/omakub # or some other directory in your $PATH
```

Run it:
```sh
omakub
```
