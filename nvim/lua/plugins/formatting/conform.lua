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
				python = { "ruff format", "ruff_organize_imports" }, -- conform runs multiple formatters sequentially
				svelte = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				yaml = { "prettier" },
			},
			-- source: https://github.com/astral-sh/ruff-lsp/issues/387#issuecomment-2069141768
			formatters = {
				ruff_organize_imports = {
					command = "ruff",
					args = {
						"check",
						"--force-exclude",
						"--select=I001",
						"--fix",
						"--exit-zero",
						"--stdin-filename",
						"$FILENAME",
						"-",
					},
					stdin = true,
					cwd = require("conform.util").root_file({
						"pyproject.toml",
						"ruff.toml",
						".ruff.toml",
					}),
				},
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
