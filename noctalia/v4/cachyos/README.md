# CachyOS Noctalia v4 overrides

This directory customizes the Quickshell-based Noctalia v4 profile used by
`cachyos-niri-noctalia`. It keeps CachyOS's widget settings, applies our layout
changes, and installs the `Nord-Readable-Hover` color scheme. That scheme is
identical to Nord except for its light foreground on dark hover backgrounds.

The bar uses Noctalia's auto-hide mode: it retracts three seconds after the
pointer leaves and reappears when the pointer reaches the screen edge. The
existing bar-toggle IPC shortcut continues to show or hide it manually.

## Apply

`jq` is required. Run:

```sh
~/p/dotfiles/noctalia/v4/cachyos/apply-settings
```

Restart Noctalia after applying the settings:

```sh
qs -c noctalia-shell ipc call shell restart
```

If the restart IPC endpoint is unavailable, log out and back into Niri.
