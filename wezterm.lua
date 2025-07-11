local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_linux <const> = wezterm.target_triple:match("linux")
local is_windows <const> = wezterm.target_triple:match("windows")

if is_linux then
    config.default_prog = { "bash" }
elseif is_windows then
    config.default_prog = { "pwsh" }
end

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
    -- Fix Ctrl-Space not being sent to CLI
    {
        mods = "CTRL", key = " ",
        action = wezterm.action.SendKey{ mods = "CTRL", key = " " },
    },
}

-- Alt-hjkl to navigate panes in a tab
for key, direction in pairs{h = "Left", j = "Down", k = "Up", l = "Right"} do
    table.insert(config.keys, {
        mods = "ALT", key = key,
        action = wezterm.action.ActivatePaneDirection(direction),
    })
end

-- Alt-HJKL to resize panes
for key, direction in pairs{H = "Left", J = "Down", K = "Up", L = "Right"} do
    table.insert(config.keys, {
        mods = "ALT", key = key,
        action = wezterm.action.AdjustPaneSize{ direction, 1 },
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
config.font_size = 13.5

if is_windows then
    config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
end
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.use_fancy_tab_bar = false

return config
