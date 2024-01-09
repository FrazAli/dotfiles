return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {
					config = {
						icon_preset = "basic",
						icons = {
							code_block = {
								conceal = true,
								content_only = false, -- include @code and @end lines in highlight
								width = "content",
								padding = {
									left = 2,
									right = 2,
								},
								highlight = "LspReferenceText", -- set code block highlight group to 'LspReferenceText'
							},
						},
					},
				}, -- Adds pretty icons to your documents
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/notes",
						},
						default_workspace = "notes",
					},
				},
				["core.export"] = {}, -- Export Neorg files to other formats
			},
		})
	end,
}
