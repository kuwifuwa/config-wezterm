local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.default_prog = { "pwsh" }

config.enable_kitty_keyboard = true
config.keys = {
    {
        mods = "ALT", key = "w",
        action = wezterm.action.CloseCurrentPane{ confirm = true },
    },
    {
        mods = "ALT", key = "s",
        action = wezterm.action.SplitVertical{},
    },
    {
        mods = "ALT", key = "d",
        action = wezterm.action.SplitHorizontal{},
    },
    {
        mods = "ALT", key = "a",
        action = wezterm.action.PaneSelect{ mode = "SwapWithActive" },
    },
}

-- Alt-hjkl to navigate panes in a tab
for key, direction in pairs{h = "Left", j = "Down", k = "Up", l = "Right"} do
    table.insert(config.keys, {
        mods = "ALT", key = key,
        action = wezterm.action.ActivatePaneDirection(direction),
    })
end

-- Alt-number to navigate tabs
for i = 0, 9 do
    table.insert(config.keys, {
        mods = "ALT", key = tostring((i + 1) % 10),
        action = wezterm.action.ActivateTab(i),
    })
end

-- Ctrl-Alt-number to move a tab
for i = 0, 9 do
    table.insert(config.keys, {
        mods = "CTRL|ALT", key = tostring((i + 1) % 10),
        action = wezterm.action.MoveTab(i),
    })
end

--config.color_scheme = ""
config.font = wezterm.font{
    family = "JetBrains Mono",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
}

config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.use_fancy_tab_bar = false

return config
