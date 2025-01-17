local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.default_prog = { "pwsh" }

config.enable_kitty_keyboard = true
config.keys = {
    {
        key = "t",
        mods = "ALT",
        action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    {
        key = "w",
        mods = "ALT",
        action = wezterm.action.CloseCurrentPane{ confirm = true },
    },
    {
        key = "s",
        mods = "ALT",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
        key = "d",
        mods = "ALT",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
        key = "h",
        mods = "ALT",
        action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
        key = "j",
        mods = "ALT",
        action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
        key = "k",
        mods = "ALT",
        action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
        key = "l",
        mods = "ALT",
        action = wezterm.action.ActivatePaneDirection("Right"),
    },
}
-- "ALT + number" keys to navigate tabs
for i = 0, 9 do
    table.insert(config.keys, {
        key = tostring((i + 1) % 10),
        mods = "ALT",
        action = wezterm.action.ActivateTab(i),
    })
end
-- CTRL+ALT + number to move to that position
for i = 0, 9 do
    table.insert(config.keys, {
        key = tostring((i + 1) % 10),
        mods = "CTRL|ALT",
        action = wezterm.action.MoveTab(i),
    })
end

--config.color_scheme = ""
config.font = wezterm.font("JetBrains Mono")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.use_fancy_tab_bar = false

return config
