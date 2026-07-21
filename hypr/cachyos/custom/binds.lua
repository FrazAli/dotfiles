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

-- Show or hide the Noctalia status bar without replacing SUPER + S.
hl.bind("CONTROL + SUPER + S", hl.dsp.exec_cmd("noctalia msg bar-toggle"))

-- macOS-style selected-region screenshot shortcut.
hl.bind("SUPER + SHIFT + 4", hl.dsp.exec_cmd("noctalia msg screenshot-region"))

-- Toggle between the current and previously focused window across workspaces.
hl.unbind("ALT + Tab")
hl.bind("ALT + Tab", hl.dsp.focus({ last = true }), {
    description = "Switch to previously focused window",
})
