return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	-- slanted bars	" ",
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		heading = {
			width = "block",
			position = "inline",
			-- signs = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },
			signs = { " █", " █", " █", " █", " █", " █" },
			icons = { "⓵  ", "⓶  ", "⓷  ", "⓸  ", "⓹  ", "⓺  " },
		},
	},
}
