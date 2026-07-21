-- Personal keybindings for the CachyOS Hyprland + Noctalia configuration.
--
-- Add a binding directly when its key combination is unused. When replacing
-- a CachyOS binding, explicitly unbind it before adding the replacement.

-- Rectangle-style fullscreen alias. CachyOS's SUPER + F remains available.
hl.bind("CONTROL + ALT + Return", hl.dsp.window.fullscreen())

-- Move or swap the focused tile using Vim-style directions.
hl.bind("CONTROL + ALT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("CONTROL + ALT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind("CONTROL + ALT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("CONTROL + ALT + L", hl.dsp.window.move({ direction = "r" }))

-- macOS Control + Command + Q lock-screen shortcut.
hl.bind("CONTROL + SUPER + Q", hl.dsp.exec_cmd("noctalia msg session lock"))
