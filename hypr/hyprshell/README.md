# Hyprshell

This configuration provides an Alt+Tab window switcher across all regular
Hyprland workspaces. Special workspaces are excluded.

## Install

Install the prebuilt AUR package:

```sh
paru -S hyprshell-bin
```

Link this directory into the standard configuration location:

```sh
ln -s "$HOME/p/dotfiles/hypr/hyprshell" "$HOME/.config/hyprshell"
```

Enable the user service:

```sh
systemctl --user enable --now hyprshell.service
```

Validate the configuration with:

```sh
hyprshell config check
```

Run `hyprshell config edit` to adjust the configuration in the graphical
settings editor. Changes are written through the symlink into this directory.
