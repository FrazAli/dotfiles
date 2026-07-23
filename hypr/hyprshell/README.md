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

When another compositor is installed alongside Hyprland, link the service
override so Hyprshell is skipped in every non-Hyprland graphical session:

```sh
mkdir -p "$HOME/.config/systemd/user/hyprshell.service.d"
ln -s "$HOME/p/dotfiles/hypr/hyprshell/systemd/hyprshell.service.d/override.conf" \
  "$HOME/.config/systemd/user/hyprshell.service.d/override.conf"
systemctl --user daemon-reload
```

Validate the configuration with:

```sh
hyprshell config check
```

Run `hyprshell config edit` to adjust the configuration in the graphical
settings editor. Changes are written through the symlink into this directory.
