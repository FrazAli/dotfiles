return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		-- enable mason with nicer icons
		mason.setup({
			PATH = "append",
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- Installation is always explicit via :LspInstall or :MasonInstall.
			ensure_installed = {},
			-- Only enable language servers that are already installed by Mason.
			automatic_enable = true,
		})
	end,
}
