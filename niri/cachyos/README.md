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

Keyboard layouts are US English and Swedish. Press `Ctrl+Space` to switch
between them. For a clickable indicator, add Noctalia's **Keyboard Layout**
widget in its bar settings; clicking the widget cycles the layouts.

The overrides set Ghostty as the session terminal. To make Noctalia launch
terminal applications with Ghostty as well, set its terminal command to
`ghostty -e` in the Noctalia launcher settings.

## Noctalia 5

The custom startup module launches `noctalia --daemon` with the dedicated
profile in `custom/noctalia-profile/noctalia/`. Noctalia shortcuts use
`noctalia msg`, including overrides for the legacy commands in the CachyOS base.
The base may still try `qs -c noctalia-shell`; that obsolete command exits without
starting a shell and does not prevent the custom startup command from running.

Log out and back into Niri after changing startup commands; config reloads only
apply the keybindings. To start the shell in an existing session, run
the startup command from `custom/autostart.kdl` from a terminal.

### Migration from Noctalia v4

The history records v4 as the profile supplied by `cachyos-niri-noctalia`
(commit `726ea0f`), rather than documenting a deliberate version pin or a v5
blocker. Subsequent commits customized hover contrast (`d42df97`), the overview
button (`47933af`), auto-hide (`b41988d`), and keyboard switching (`5b77d32`).

The native Noctalia 5 profile restores the icon-only active window, overview
button, workspace labels, system monitors, brightness/volume/battery controls,
notifications, control center, and short clock. A keyboard layout indicator is
also included. It uses 50% bar opacity, square corners, no shadows, and a
three-second auto-hide delay. V5 controls pointer reveal itself; the old 100 ms
v4 reveal delay has no direct setting in this profile.

The Nord-Readable-Hover palette is preserved, including light hover text. Its
JSON is copied from the v4 palette because v5 custom palettes accept the same
color fields. Wallpaper defaults to `~/Pictures/Wallpapers/north.png`, recovered
from v4's wallpaper cache. Template generation is disabled to avoid changing
other applications' themes while migrating the desktop appearance.

`NOCTALIA_CONFIG_HOME` points to `~/.config/niri/custom/noctalia-profile`, and
`NOCTALIA_STATE_HOME` points to `${XDG_STATE_HOME:-$HOME/.local/state}/niri`.
Noctalia appends `/noctalia` to both. This keeps Niri's config and GUI overrides
separate from the existing Hyprland profile. The old JSON settings and the
Hyprland TOML files are preserved. V5's clipboard service stays disabled to
match the old profile's disabled clipboard history; enable it in settings if
clipboard history is wanted.

Validate the profile with:

```sh
noctalia config validate ~/.config/niri/custom/noctalia-profile/noctalia
niri validate
```
