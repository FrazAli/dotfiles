-- # Features & Default Keymaps:
-- ## Picking Colors:
-- ### By default:
--
-- h and l will increment the color slider value by 1.
--
-- u and i / a and d / A and D will increment the color slider value by 5.
--
-- s and w / S and W will increment the color slider value by 10.
--
-- o will change your color output
--
-- Number 0 to 9 will set the slider at your cursor to certain percentages. 0 sets to 0%, 9 sets to 90%, 5 sets to 50%.
--
-- H sets to 0%, M sets to 50%, L sets to 100%.
--
-- ## Multiple Sliders:
-- ### By default:
--
-- If your slider is on the 4th line (the same line as the color output preview), when you increment / set a color value, it will apply that change to all 3 sliders above it.
-- gu will select the 1st and 2nd sliders, gd will select the 2nd and 3rd sliders, gm will select the 1st and 3rd sliders.
-- Press x will deselect the slider group.
-- Manual Numeric Input:
-- If you press n, you can press number keys to input the color value manually for individual sliders or slider group. If you press any key that is not a number key, it will execute that key as normal.
-- For example: if you want to input 15 on the 1st slider: move your cursor to the 1st slider, press n then press 15. Then you can press k to move on to the next slider. The slider values will update as you type out the numbers.
-- Converting Colors (RGB/HEX/HSL)
-- When your cursor is on a corlor, use :PickColor to open up the picker, then press o to change the output type to RGB/HEX/HSL. Press Enter and the color under your cursor will be converted.
--
-- ## Transparency Mode
-- Press t to toggle Transparency Slider. While this mode is active, you will only be able to output the color as rgba() or hsla(). If you want to output as HEX, press t to get out of Transparency Mode, and you'll be able to press o to output your color as HEX.
--
-- ## Available Commands:
-- Click this Dropdown to see Available Commands
-- <Plug>ColorPickerSlider10Decrease
-- <Plug>ColorPickerSlider10Increase
-- <Plug>ColorPickerSlider5Decrease
-- <Plug>ColorPickerSlider5Increase
-- <Plug>ColorPickerSlider1Decrease
-- <Plug>ColorPickerSlider1Increase
--
-- <Plug>ColorPickerSlider0Percent
-- <Plug>ColorPickerSlider10Percent
-- <Plug>ColorPickerSlider20Percent
-- <Plug>ColorPickerSlider30Percent
-- <Plug>ColorPickerSlider40Percent
-- <Plug>ColorPickerSlider50Percent
-- <Plug>ColorPickerSlider60Percent
-- <Plug>ColorPickerSlider70Percent
-- <Plug>ColorPickerSlider80Percent
-- <Plug>ColorPickerSlider90Percent
-- <Plug>ColorPickerSlider100Percent
--
-- <Plug>ColorPickerSetActionGroup1and2
-- <Plug>ColorPickerSetActionGroup2and3
-- <Plug>ColorPickerSetActionGroup123
-- <Plug>ColorPickerSetActionGroup1and3
-- <Plug>ColorPickerClearActionGroup
--
-- <Plug>ColorPickerChangeOutputType
-- <Plug>ColorPickerChangeColorMode
-- <Plug>ColorPickerApplyColor
-- <Plug>ColorPickerToggleTransparency
-- <Plug>ColorPickerNumericInput

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
