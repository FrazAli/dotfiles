# CachyOS Hyprland overrides

This directory contains personal overrides that depend on the CachyOS
Hyprland + Noctalia configuration. It intentionally does not copy or take
ownership of the CachyOS base configuration in `~/.config/hypr`.

## Install

Create a symlink for the custom module alongside `hyprland.lua`:

```sh
ln -s "$HOME/p/dotfiles/hypr/cachyos/custom_binds.lua" \
  "$HOME/.config/hypr/custom_binds.lua"
```

Then add this as the final line of `~/.config/hypr/hyprland.lua`:

```lua
require("custom_binds")
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
