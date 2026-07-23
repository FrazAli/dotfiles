# CachyOS Noctalia v4 overrides

This directory customizes the Quickshell-based Noctalia v4 profile used by
`cachyos-niri-noctalia`. It keeps CachyOS's widget settings and applies only
our layout changes.

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
