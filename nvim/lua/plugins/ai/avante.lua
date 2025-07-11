return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = true,
	opts = {
		-- For adding other custom providers see: https://github.com/yetone/avante.nvim/wiki/Custom-providers
		providers = {
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-3-5-sonnet-20241022",
				extra_request_body = {
					temperature = 0,
					max_tokens = 4096,
				},
			},
		},
	},
	build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to setup it properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}

--
