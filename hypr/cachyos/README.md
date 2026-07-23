# CachyOS Hyprland overrides

This directory contains personal overrides that depend on the CachyOS
Hyprland + Noctalia configuration. It intentionally does not copy or take
ownership of the CachyOS base configuration in `~/.config/hypr`.

## Install

### Hyprshell window switcher

Install Hyprshell first for a better `Alt+Tab` window switcher across regular
Hyprland workspaces:

```sh
paru -S hyprshell-bin
ln -s "$HOME/p/dotfiles/hypr/hyprshell" "$HOME/.config/hyprshell"
systemctl --user enable --now hyprshell.service
```

When another compositor is installed alongside Hyprland, also install the
tracked systemd override. The upstream service's desktop check still starts
Hyprshell in non-Hyprland graphical sessions; this override skips it cleanly:

```sh
mkdir -p "$HOME/.config/systemd/user/hyprshell.service.d"
ln -s "$HOME/p/dotfiles/hypr/hyprshell/systemd/hyprshell.service.d/override.conf" \
  "$HOME/.config/systemd/user/hyprshell.service.d/override.conf"
systemctl --user daemon-reload
```

See [`../hyprshell/README.md`](../hyprshell/README.md) for validation and
configuration details.

### Personal overrides

Create one directory symlink for all custom modules:

```sh
ln -s "$HOME/p/dotfiles/hypr/cachyos/custom" \
  "$HOME/.config/hypr/custom"
```

Then add this as the final line of `~/.config/hypr/hyprland.lua`:

```lua
require("custom.init")
```

Loading the module last is required. A new, unused shortcut can be bound
normally. To replace a CachyOS shortcut, call `hl.unbind()` for the exact key
combination before defining its replacement with `hl.bind()`.

Validate and apply changes with:

```sh
Hyprland --verify-config --config "$HOME/.config/hypr/hyprland.lua"
hyprctl reload
hyprctl configerrors
```
