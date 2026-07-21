# CachyOS Noctalia overrides

Noctalia v5 automatically merges every root-level TOML file in
`~/.config/noctalia/` in alphabetical order. For example,
`zz-custom-bar.toml` sorts after the CachyOS `config.toml`, so its bar values
override conflicting CachyOS values.

Link the bar override using that name:

```sh
ln -s ~/p/dotfiles/noctalia/cachyos/bar.toml \
  ~/.config/noctalia/zz-custom-bar.toml
```

Noctalia applies configuration in this order:

1. Built-in Noctalia defaults.
2. TOML files in `~/.config/noctalia/`, in alphabetical order. This loads the
   CachyOS `config.toml` before our linked `zz-custom-bar.toml`.
3. Changes made through the GUI stored in `~/.local/state/noctalia/settings.toml`.

The GUI-managed `settings.toml` does not replace the complete configuration.
A value there wins only when it configures the same setting as one of the
files in `~/.config/noctalia/`.
