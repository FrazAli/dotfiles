# Add new plugins

1. Go into the 'plugins/start' directory and add new submodules:

```
cd plugins/start
git submodule add <git-repository-path>
```

2. [Optional] add a configuration for the plugin if needed:

```
nvim lua/plugins/<plugin-name>.lua
```

3. [Optional] Add any new key bindings:

```
nvim lua/keymaps.lua
```

4. Update `init.lua` to involke the plugin with / without config.

5. Run make to `rsync` plugins to the host system, see the Makefile for more details.

# Editor settings

General neovim settings are configured through `lua/settings.lua`

# Key mappings

Key maps are configured through `lua/keymaps.lua`
