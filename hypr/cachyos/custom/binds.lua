-- Personal keybindings for the CachyOS Hyprland + Noctalia configuration.
--
-- Add a binding directly when its key combination is unused. When replacing
-- a CachyOS binding, explicitly unbind it before adding the replacement.

-- Rectangle-style fullscreen alias. CachyOS's SUPER + F remains available.
hl.bind("CONTROL + ALT + Return", hl.dsp.window.fullscreen())

-- macOS Control + Command + Q lock-screen shortcut.
hl.bind("CONTROL + SUPER + Q", hl.dsp.exec_cmd("noctalia msg session lock"))
