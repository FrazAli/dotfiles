-- macOS-style Command shortcuts for Firefox and Firefox Developer Edition.
-- Each shortcut retains its intended fallback when Firefox is not focused.

local firefox_classes = {
    ["firefox"] = true,
    ["firefox-developer-edition"] = true,
}

local function firefox_is_active()
    local window = hl.get_active_window()
    return window ~= nil and firefox_classes[string.lower(window.class)] == true
end

local function firefox_shortcut(key, fallback)
    local shortcut = "SUPER + " .. key

    hl.unbind(shortcut)
    hl.bind(shortcut, function()
        if firefox_is_active() then
            hl.dispatch(hl.dsp.send_shortcut({
                mods = "CTRL",
                key = key,
                window = "activewindow",
            }))
        else
            hl.dispatch(fallback())
        end
    end, { description = "macOS-style Firefox shortcut" })
end

firefox_shortcut("T", function()
    return hl.dsp.exec_cmd("uwsm app -- " .. TERMINAL)
end)

firefox_shortcut("W", function()
    return hl.dsp.no_op()
end)

firefox_shortcut("F", function()
    return hl.dsp.window.fullscreen()
end)

firefox_shortcut("B", function()
    return hl.dsp.pass({ window = "activewindow" })
end)

firefox_shortcut("L", function()
    return hl.dsp.exec_cmd("noctalia msg session lock")
end)

firefox_shortcut("P", function()
    return hl.dsp.exec_cmd("hyprpicker -a")
end)
