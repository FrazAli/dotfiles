return {
	"laytan/tailwind-sorter.nvim",
	lazy = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
	},
	build = "cd formatter && npm ci && npm run build",
	config = function()
		require("tailwind-sorter").setup({
			on_save_enabled = function(bufnr)
				-- Enable formatting based on FormatCommand set from Conform.nvim config
				if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
					return false
				end
				return true
			end,
			on_save_pattern = { "*.html", "*.jsx", "*.tsx", "*.astro" }, -- The file patterns to watch and sort.
			node_path = "node",
			trim_spaces = true, -- If `true`, trim any extra spaces after sorting.
		})
	end,
}
