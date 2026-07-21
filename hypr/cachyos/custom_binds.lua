-- Personal keybindings for the CachyOS Hyprland + Noctalia configuration.
--
-- This module is intentionally limited to personal binding overrides. Add a
-- binding directly when its key combination is unused. When replacing a
-- CachyOS binding, explicitly unbind it first and then add the replacement.
--
-- Example:
--
-- hl.unbind("SUPER + T")
-- hl.bind("SUPER + T", hl.dsp.exec_cmd("uwsm app -- " .. TERMINAL))
--
-- The module must be loaded after CachyOS's config.binds module so that the
-- original bindings exist before any explicit unbind calls run.

-- Rectangle-style fullscreen alias. CachyOS's SUPER + F remains available.
hl.bind("CONTROL + ALT + Return", hl.dsp.window.fullscreen())

-- macOS Control + Command + Q lock-screen shortcut.
hl.bind("CONTROL + SUPER + Q", hl.dsp.exec_cmd("noctalia msg session lock"))

-- Replace CachyOS's editor shortcut with a terminal launcher.
hl.unbind("SUPER + T")
hl.bind("SUPER + T", hl.dsp.exec_cmd("uwsm app -- " .. TERMINAL))
