-- Re-run personal overrides on every Hyprland reload. Lua caches nested
-- modules, which would otherwise let the CachyOS defaults take precedence.
local function reload(module)
	package.loaded[module] = nil
	require(module)
end

reload("custom.appearance")
reload("custom.binds")
reload("custom.firefox")
