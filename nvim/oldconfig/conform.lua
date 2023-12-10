require("conform").setup({
	formatters_by_ft = {
		css = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		markdown = { "prettier" },
		svelte = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		yaml = { "prettier" },
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		async = false, -- setting this true means the timeout has no effect
		timeout_ms = 500, -- formatting timeout for sync formatting
		lsp_fallback = true, -- fallback to LSP if there is no Formatter
	},
})
