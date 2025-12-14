-- This config. file is for wezterm on Windows OS.
-- Copy and rename this file into user's home directory, e.g.
--      C:\Users\[UserName]\.wezterm.lua
local wezterm = require("wezterm")

return {
	wsl_domains = {
		{
			-- The name of this specific domain.  Must be unique amonst all types
			-- of domain in the configuration file.
			name = "WSL:Debian11",

			-- The name of the distribution.  This identifies the WSL distribution.
			-- It must match a valid distribution from your `wsl -l -v` output in
			-- order for the domain to be useful.
			distribution = "Debian",

			-- The username to use when spawning commands in the distribution.
			-- If omitted, the default user for that distribution will be used.

			-- username = "hunter",

			-- The current working directory to use when spawning commands, if
			-- the SpawnCommand doesn't otherwise specify the directory.

			-- default_cwd = "/tmp"

			-- The default command to run, if the SpawnCommand doesn't otherwise
			-- override it.  Note that you may prefer to use `chsh` to set the
			-- default shell for your user inside WSL to avoid needing to
			-- specify it here

			-- default_prog = {"fish"}
		},
	},
	enable_tab_bar = false,
	color_scheme = "Catppuccin Mocha",

	-- Background opacity and blur
	window_background_opacity = 0.6,
	win32_system_backdrop = "Acrylic",
	-- Removes title bar, "RESIZE" allow re-sizing borders, default is "TITLE | RESIZE"
	window_decorations = "RESIZE",
	keys = {
		{
			key = "F11",
			action = wezterm.action.ToggleFullScreen,
		},
	},

	audible_bell = "Disabled",

	-- Font properties
	font_dirs = {
		"C:\\USERS\\DATORN\\APPDATA\\LOCAL\\MICROSOFT\\WINDOWS\\FONTS",
		"C:\\USERS\\DATORN\\.LOCAL\\SHARE\\FONTS",
	},
	font = wezterm.font("MesloLGM Nerd Font Propo", {
		weight = "Regular",
		stretch = "Normal",
		style = "Normal",
	}), -- C:\USERS\DATORN\APPDATA\LOCAL\MICROSOFT\WINDOWS\FONTS\MESLOLGLNERDFONT-REGULAR.TTF, DirectWrite
	font_size = 15,

	-- Click to open url in the browser
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
	-- This changes the default program from cmd.exe to wsl.exe
	-- Note: In order to change the distribution for wsl, set default
	--       distribution from wsl.exe, example: wsl.exe -s Debian

	default_prog = { "wsl.exe" },
}
