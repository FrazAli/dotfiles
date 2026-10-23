# CachyOS Noctalia v4 overrides

This directory customizes the Quickshell-based Noctalia v4 profile used by
`cachyos-niri-noctalia`. It keeps CachyOS's widget settings, applies our layout
changes, and installs the `Nord-Readable-Hover` color scheme. That scheme is
identical to Nord except for its light foreground on dark hover backgrounds.

The bar uses Noctalia's auto-hide mode: it retracts three seconds after the
pointer leaves and reappears when the pointer reaches the screen edge. The
existing bar-toggle IPC shortcut continues to show or hide it manually.

## Noctalia 5 migration

This profile is retained for reference. The October 2026 update replaced its
QML entrypoint with native Noctalia 5. Niri now uses the migrated profile in
`niri/cachyos/custom/noctalia-profile/noctalia`; see `niri/cachyos/README.md`
for setup, history findings, and configuration differences.

## Apply (v4 only)

`jq` is required. Run:

```sh
~/p/dotfiles/noctalia/v4/cachyos/apply-settings
```

Restart Noctalia after applying the settings:

```sh
qs -c noctalia-shell ipc call shell restart
```

If the restart IPC endpoint is unavailable, log out and back into Niri.
