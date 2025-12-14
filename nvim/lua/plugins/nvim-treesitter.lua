return {
	{
		"nvim-treesitter/nvim-treesitter",
		priority = 1000,
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local languages = {
				"bash",
				"c",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"html",
				"javascript",
				"json",
				"latex",
				"lua",
				"markdown",
				"markdown_inline",
				"norg",
				"python",
				"query",
				"regex",
				"rust",
				"scss",
				"svelte",
				"terraform",
				"tsx",
				"typescript",
				"typst",
				"vim",
				"vimdoc",
				"vue",
				"xml",
				"yaml",
			}

			-- Configure install dir (optional; defaults to stdpath('data')/site).
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- Start treesitter highlighting and set indentexpr for desired filetypes.
			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			-- Kick off async parser install; no-op if already installed.
			pcall(require("nvim-treesitter").install, languages)
		end,
	},
}
