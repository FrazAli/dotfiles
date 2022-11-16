-- This config. file is for wezterm on macOS.
-- Copy and rename this file into user's home directory, e.g.
--      $HOME/.wezterm.lua

local wezterm = require 'wezterm'

return {
  -- Font properties
  font = wezterm.font("Hack Nerd Font Mono", {
    weight="Bold",
    stretch="Normal",
    style="Normal"
  }),

  font_size = 16.0,

  -- Wondow properties
  enable_tab_bar = false,
  window_background_opacity = 0.85,
}

