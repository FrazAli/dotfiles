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

-- macOS-style system-wide select-all, copy, and paste shortcuts.
hl.unbind("SUPER + A")
hl.bind(
	"SUPER + A",
	hl.dsp.send_shortcut({
		mods = "CTRL",
		key = "A",
		window = "activewindow",
	})
)

hl.unbind("SUPER + C")
hl.bind(
	"SUPER + C",
	hl.dsp.send_shortcut({
		mods = "CTRL",
		key = "C",
		window = "activewindow",
	})
)

hl.unbind("SUPER + V")
hl.bind(
	"SUPER + V",
	hl.dsp.send_shortcut({
		mods = "CTRL",
		key = "V",
		window = "activewindow",
	})
)

-- The clipboard panel displaced from SUPER + V by the paste shortcut above.
hl.bind("CONTROL + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))

-- Replace the special-workspace shortcuts with a status-bar toggle.
hl.unbind("SUPER + SHIFT + S")
hl.unbind("SUPER + S")
hl.bind("SUPER + S", hl.dsp.exec_cmd("noctalia msg bar-toggle"))

-- macOS-style selected-region screenshot shortcut.
hl.bind("SUPER + SHIFT + 4", hl.dsp.exec_cmd("noctalia msg screenshot-region"))

-- Toggle between the current and previously focused window across workspaces.
hl.unbind("ALT + Tab")
hl.bind("ALT + Tab", hl.dsp.focus({ last = true }), {
	description = "Switch to previously focused window",
})
