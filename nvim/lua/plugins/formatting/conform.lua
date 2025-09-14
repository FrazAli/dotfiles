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
				python = { "ruff_format", "ruff_organize_imports" }, -- conform runs multiple formatters sequentially
				rego = { "opa" },
				svelte = { "prettier" },
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				yaml = { "prettier" },
			},
			-- source: https://github.com/astral-sh/ruff-lsp/issues/387#issuecomment-2069141768
			formatters = {
				opa = {
					command = "opa",
					args = { "fmt" },
					stdin = true,
				},
				ruff_all = {
					command = "sh",
					args = {
						"-c",
						table.concat({
							'ruff format --stdin-filename "$1" -',
							"&& ruff check --force-exclude --select=I001 --fix",
							'--exit-zero --stdin-filename "$1" -',
						}, " "),
						"_",
						"$FILENAME",
					},
					stdin = true,
					cwd = require("conform.util").root_file({
						"pyproject.toml",
						"ruff.toml",
						".ruff.toml",
					}),
				},
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
					return false
				end
				return {
					-- These options will be passed to conform.format()
					async = false, -- setting this true means the timeout has no effect
					timeout_ms = 500, -- formatting timeout for sync formatting
					lsp_format = "fallback", -- fallback to LSP if there is no Formatter
				}
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				async = false,
				timeout_ms = 1000,
				lsp_fallback = true,
			})
		end, { desc = "[F]ormat file or range (in visual mode)" })

		-- Command to disable auto-format on save
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- 'ConformFormatDisable!' will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})

		-- Command to re-enable auto-format on save
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
