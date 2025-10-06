return {
	"nvim-lualine/lualine.nvim",
	priority = 30,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- local colors = {
		-- 	blue = "#61afef",
		-- 	green = "#98c379",
		-- 	purple = "#c678dd",
		-- 	cyan = "#56b6c2",
		-- 	red1 = "#e06c75",
		-- 	red2 = "#be5046",
		-- 	yellow = "#e5c07b",
		-- 	fg = "#abb2bf",
		-- 	bg = "#282c34",
		-- 	gray1 = "#828997",
		-- 	gray2 = "#2c323c",
		-- 	gray3 = "#3e4452",
		-- }
		require("lualine").setup({
			options = {
				icons_enabled = true,
				component_separators = "|",
				section_separators = "",
				-- catppuccin colors: #89b4fa, #a6e3a1, #cba6f7, #fab387
				-- nord colors: #81a1c1, #98c379, #c678dd, #e5c07b
				theme = {
					normal = {
						a = { fg = "#1e1e2e", bg = "#89b4fa" },
						b = { fg = "#89b4fa", bg = "#313244" },
						c = { bg = "NONE" },
						x = { bg = "NONE" },
					},
					insert = {
						a = { fg = "#1e1e2e", bg = "#abb2bf" },
						b = { fg = "#abb2bf", bg = "#313244" },
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
						a = { fg = "#1e1e2e", bg = "#e5c07b" },
						b = { fg = "#e5c07b", bg = "#313244" },
						c = { bg = "NONE" },
						x = { bg = "NONE" },
					},
					-- leave everything else to the theme defaults
				},
			},
			sections = {
				lualine_a = { "filename" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						path = 1,
						color = { fg = "#616e88", bg = "#NONE" },
						symbols = {
							modified = " ",
							readonly = " ",
							unnamed = "[No Name]",
							newfile = "[New]",
						},
					},
				},
				lualine_x = {},
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
		})
	end,
}
