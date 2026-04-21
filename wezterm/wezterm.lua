-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font('JetBrains Mono')
config.max_fps = 240
config.animation_fps = 240
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.font_size = 18
-- For example, changing the color scheme:
config.color_scheme = 'Tokyo Night'

-- Enable kitty keyboard protocol so Shift+Space is distinct from Space
config.enable_kitty_keyboard = true
config.custom_block_glyphs = false
config.hide_tab_bar_if_only_one_tab = true

-- Pass Alt keys through to terminal apps (e.g. tmux pane navigation with Alt+h/j/k/l)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- and finally, return the configuration to wezterm
return config
