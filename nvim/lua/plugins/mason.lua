return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

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
			-- list of servers for mason to install
			ensure_installed = {
				"cssls",
				"emmet_language_server",
				"html",
				"lua_ls",
				"matlab_ls",
				"pyright",
				"rust_analyzer",
				"svelte",
				"tailwindcss",
				"terraformls",
				"ts_ls",
				"regal",
			},
			-- auto-install configured servers (with lspconfig)
			-- disable it to let neovim's builtin 'vim.lsp.enable()' api handle it
			automatic_installation = false,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"ruff", -- python formatter
				"stylelint", -- css linter
				"tflint", -- terraform linter
				"regal", -- rego linter
			},
		})
	end,
}
