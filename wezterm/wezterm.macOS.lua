-- This config. file is for wezterm on macOS.
-- Copy and rename this file into user's home directory, e.g.
--      $HOME/.wezterm.lua

local wezterm = require("wezterm")

return {
	-- Font properties
	font = wezterm.font("Hack Nerd Font Mono", {
		weight = "Bold",
		stretch = "Normal",
		style = "Normal",
	}),

	font_size = 16.0,

	-- Window properties
	enable_tab_bar = false,

	-- Color scheme
	color_scheme = "Catppuccin Mocha",

	-- Background opacity and blur
	window_background_opacity = 0.6,
	macos_window_background_blur = 30,

	-- Click to open url in the browser
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CMD",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
