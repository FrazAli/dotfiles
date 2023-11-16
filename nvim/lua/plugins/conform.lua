require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black", "flake8" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettier", "prettierd" } },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500, -- formatting timeout for sync formatting
		lsp_fallback = true,
	},
})
