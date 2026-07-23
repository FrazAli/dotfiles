# CachyOS Niri overrides

This directory contains personal overrides layered on top of the CachyOS Niri
configuration. It does not copy or take ownership of the CachyOS base files in
`~/.config/niri/cfg`.

## Install

Link the custom module directory:

```sh
ln -s "$HOME/p/dotfiles/niri/cachyos/custom" \
  "$HOME/.config/niri/custom"
```

Then add this as the final line of `~/.config/niri/config.kdl`:

```kdl
include "./custom/config.kdl"
```

The final position is important because later includes override conflicting
settings and keybindings from earlier includes.

Validate the merged configuration with:

```sh
niri validate
```

Niri watches the entrypoint and all included files, so valid changes are
reloaded automatically.

The overrides set Ghostty as the session terminal. To make Noctalia launch
terminal applications with Ghostty as well, set its terminal command to
`ghostty -e` in the Noctalia launcher settings.
