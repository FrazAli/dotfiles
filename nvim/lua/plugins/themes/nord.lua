return {
	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 29,
		config = function()
			require("nord").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				transparent = false, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
				diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
				borders = true, -- Enable the border between verticaly split windows visible
				errors = { mode = "bg" }, -- Display mode for errors and diagnostics
				-- values : [bg|fg|none]
				search = { theme = "vim" }, -- theme for highlighting search results
				-- values : [vim|vscode]
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = {},
					functions = {},
					variables = {},

					-- To customize lualine/bufferline
					bufferline = {
						current = {},
						modified = { italic = true },
					},

					lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
				},

				-- colorblind mode
				-- see https://github.com/EdenEast/nightfox.nvim#colorblind
				-- simulation mode has not been implemented yet.
				colorblind = {
					enable = false,
					preserve_background = false,
					severity = {
						protan = 0.0,
						deutan = 0.0,
						tritan = 0.0,
					},
				},

				-- Override the default colors
				---@param colors Nord.Palette
				on_colors = function(colors) end,

				--- You can override specific highlights to use other groups or a hex color
				--- function will be called with all highlights and the colorScheme table
				--- @see https://github.com/gbprod/nord.nvim/lua/nord/colors.lua
				---  polar_night = {
				---    origin = "#2E3440", -- nord0
				---    bright = "#3B4252", -- nord1
				---    brighter = "#434C5E", -- nord2
				---    brightest = "#4C566A", -- nord3
				---    light = "#616E88", -- out of palette
				---  },
				---  snow_storm = {
				---    origin = "#D8DEE9", -- nord4
				---    brighter = "#E5E9F0", -- nord5
				---    brightest = "#ECEFF4", -- nord6
				---  },
				---  frost = {
				---    polar_water = "#8FBCBB", -- nord7
				---    ice = "#88C0D0", -- nord8
				---    artic_water = "#81A1C1", -- nord9
				---    artic_ocean = "#5E81AC", -- nord10
				---  },
				---  aurora = {
				---    red = "#BF616A", -- nord11
				---    orange = "#D08770", -- nord12
				---    yellow = "#EBCB8B", -- nord13
				---    green = "#A3BE8C", -- nord14
				---    purple = "#B48EAD", -- nord15
				---  },
				---  none = "NONE",
				---@param colors Nord.Palette
				on_highlights = function(highlights, colors)
					-- Tranparent tabline
					highlights.TabLine = { bg = "NONE" }
					highlights.TabLineSel = { bg = "NONE" }
					highlights.TabLineFill = { bg = "NONE" }

					-- Transparent popups
					highlights.Pmenu = { bg = "NONE" }
					highlights.PmenuSel = { link = "CursorLine" }
					highlights.PmenuThumb = { link = "CursorLine" }
					highlights.PmenuSbar = { bg = "NONE" }

					-- Transparent Cmdline
					highlights.WildMenu = { bg = "NONE" }

					-- Float Border and Background
					highlights.FloatBorder = { bg = "NONE", fg = "#616E88" }
					highlights.NormalFloat = { bg = "NONE" }
					highlights.FloatTitle = { bg = "NONE" }
					highlights.TelescopeBorder = { bg = "NONE", fg = "#616E88" }

					-- Transparent command line
					highlights.WildMenu = { bg = "NONE" }
					highlights.CmdLine = { bg = "NONE" }
					highlights.MsgArea = { bg = "NONE" }

					-- Markdown
					-- Headings
					highlights["@markup.heading.1"] = { fg = "#f38ba8" }
					highlights["@markup.heading.2"] = { fg = "#fab387" }
					highlights["@markup.heading.3"] = { fg = "#f9e2af" }
					highlights["@markup.heading.4"] = { fg = "#a6e3a1" }
					highlights["@markup.heading.5"] = { fg = "#89b4fa" }
					highlights["@markup.heading.6"] = { fg = "#cba6f7" }
					highlights["RenderMarkdownH1Bg"] = { bg = "#4f2b3a" }
					highlights["RenderMarkdownH2Bg"] = { bg = "#523c2a" }
					highlights["RenderMarkdownH3Bg"] = { bg = "#534b3a" }
					highlights["RenderMarkdownH4Bg"] = { bg = "#374b36" }
					highlights["RenderMarkdownH5Bg"] = { bg = "#2c3b52" }
					highlights["RenderMarkdownH6Bg"] = { bg = "#443752" }

					-- Lists and Checkbox
					highlights["RenderMarkdownBullet"] = { fg = "#89b4fa" }
					highlights["RenderMarkdownUnchecked"] = { fg = "#89b4fa" }
					highlights["RenderMarkdownChecked"] = { fg = "#a6e3a1" }
				end,
			})

			vim.cmd.colorscheme("nord")
		end,
	},
}
