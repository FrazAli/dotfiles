return {
	"ziontee113/color-picker.nvim",
	lazy = true,
	config = function()
		require("color-picker").setup({
			-- ["icons"] = { "ﱢ", "" },
			-- ["icons"] = { "ﮊ", "" },
			-- ["icons"] = { "", "ﰕ" },
			-- ["icons"] = { "", "" },
			-- ["icons"] = { "", "" },
			["icons"] = { "█", "▒" },
			["border"] = "rounded", -- none | single | double | rounded | solid | shadow
			["keymap"] = { -- mapping example:
				["U"] = "<Plug>ColorPickerSlider5Decrease",
				["O"] = "<Plug>ColorPickerSlider5Increase",
			},
			["background_highlight_group"] = "Normal", -- default
			["border_highlight_group"] = "FloatBorder", -- default
			["text_highlight_group"] = "Normal", --default
		})
	end,
}
