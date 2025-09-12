return {
	"lua_ls",
	{
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		-- no root_dir: allow single-file Lua config editing
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	},
}
