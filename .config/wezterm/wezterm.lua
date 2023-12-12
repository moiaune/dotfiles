--- INITIALIZE CONFIG
local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- CONFIGURATION

-- Initial size
config.initial_cols = 80
config.initial_rows = 30

-- Launch tmux on startup
config.default_prog = { '/usr/local/bin/tmux', '-u' }

-- Default color scheme
config.color_scheme = 'Everforest Dark (Gogh)'

-- Default font
config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 16.0

-- Hide tabbar if only one tab
config.hide_tab_bar_if_only_one_tab = true

-- Make { } work for scandinavian keyboard layouts on macos
config.send_composed_key_when_left_alt_is_pressed = true

return config
