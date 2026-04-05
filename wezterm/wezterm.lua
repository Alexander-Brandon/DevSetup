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

config.keys = {
  {
    key = "|",
    mods = "SUPER|SHIFT",
    action = wezterm.action.SpawnCommandInNewTab {
      args = { wezterm.home_dir .. "/.local/bin/claude" },
    },
  },
  {
    key = "g",
    mods = "ALT",
    action = wezterm.action.SplitPane {
      direction = "Right",
      command = {
        args = { "lazygit" },
        set_environment_variables = {
          PATH = "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin",
        },
      },
    },
  },
  {
    key = "w",
    mods = "ALT",
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  { key = "[", mods = "ALT", action = wezterm.action.MoveTabRelative(-1) },
  { key = "]", mods = "ALT", action = wezterm.action.MoveTabRelative(1) },
}

-- and finally, return the configuration to wezterm
return config
