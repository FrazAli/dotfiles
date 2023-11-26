require("nvim-tree").setup({
	filters = {
		git_ignored = false,
	},
	renderer = {
		icons = {
			glyphs = {
				git = {
					untracked = "", -- default: "★",
				},
			},
		},
	},
})
