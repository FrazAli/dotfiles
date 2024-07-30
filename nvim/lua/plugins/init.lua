-- Plugins with default or no config.
return {
	"nvim-lua/plenary.nvim", -- Lua library needed by other plugins e.g. telescope
	{
		"vhyrro/luarocks.nvim", -- Luarocks is needed by Mason and other plugins
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
	},
}
