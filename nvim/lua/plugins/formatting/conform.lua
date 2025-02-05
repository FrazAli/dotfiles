return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				css = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "ruff" }, -- conform runs multiple formatters sequentially
				svelte = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				yaml = { "prettier" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				async = false, -- setting this true means the timeout has no effect
				timeout_ms = 500, -- formatting timeout for sync formatting
				lsp_fallback = true, -- fallback to LSP if there is no Formatter
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				async = false,
				timeout_ms = 1000,
				lsp_fallback = true,
			})
		end, { desc = "[F]ormat file or range (in visual mode)" })
	end,
}
