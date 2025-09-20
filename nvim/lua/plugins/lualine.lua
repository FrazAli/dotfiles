return {
	"nvim-lualine/lualine.nvim",
	priority = 30,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				component_separators = "|",
				section_separators = "",
				theme = {
					normal = {
						a = { fg = "#1e1e2e", bg = "#89b4fa" },
						b = { fg = "#89b4fa", bg = "#313244" },
						c = { bg = "NONE" },
						x = { bg = "NONE" },
					},
					insert = {
						a = { fg = "#1e1e2e", bg = "#a6e3a1" },
						b = { fg = "a6e3a1", bg = "#313244" },
						c = { bg = "NONE" },
						x = { bg = "NONE" },
					},
					visual = {
						a = { fg = "#1e1e2e", bg = "#cba6f7" },
						b = { fg = "#cba6f7", bg = "#313244" },
						c = { bg = "NONE" },
						x = { bg = "NONE" },
					},
					command = {
						a = { fg = "#1e1e2e", bg = "#fab387" },
						b = { fg = "#fab387", bg = "#313244" },
						c = { bg = "NONE" },
						x = { bg = "NONE" },
					},
					-- leave everything else to the theme defaults
				},
			},
			sections = {
				lualine_a = { "filename" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
