# keyd shortcuts

This configuration provides compositor-independent macOS-style shortcuts:

- `Super+A` sends `Ctrl+A`
- `Super+C` sends `Ctrl+C`
- `Super+V` sends `Ctrl+V`

The mappings apply before input reaches Wayland, X11, a compositor, or a
virtual console.

## Install

Install keyd, link the configuration, and enable the daemon:

```sh
sudo pacman -S --needed keyd
sudo ln -s "$HOME/p/dotfiles/keyd/default.conf" /etc/keyd/default.conf
sudo systemctl enable --now keyd.service
```

After changing the configuration, reload it with:

```sh
sudo keyd reload
```

If a bad mapping makes the keyboard unusable, keyd's emergency stop sequence
is `Backspace+Escape+Enter`.
