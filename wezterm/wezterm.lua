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

local popterm_panes = {} -- tab_id -> pane_id

local function pop_term(window, pane)
  local tab = window:active_tab()
  local tab_id = tab:tab_id()

  -- If we have a tracked PopTerm, try to close it
  local existing_id = popterm_panes[tab_id]
  if existing_id then
    for _, p in ipairs(tab:panes()) do
      if p:pane_id() == existing_id then
        p:activate()
        window:perform_action(wezterm.action.CloseCurrentPane { confirm = false }, p)
        popterm_panes[tab_id] = nil
        return
      end
    end
    -- Pane no longer exists, clear stale entry
    popterm_panes[tab_id] = nil
  end

  -- Open PopTerm in the cwd of the current pane
  local cwd_uri = pane:get_current_working_dir()
  local cwd = cwd_uri and cwd_uri.file_path or wezterm.home_dir

  local new_pane = pane:split {
    direction = "Bottom",
    size = 0.35,
    cwd = cwd,
  }
  popterm_panes[tab_id] = new_pane:pane_id()
end

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
  {
    key = "h",
    mods = "ALT",
    action = wezterm.action_callback(pop_term),
  },
  { key = "[", mods = "ALT", action = wezterm.action.MoveTabRelative(-1) },
  { key = "]", mods = "ALT", action = wezterm.action.MoveTabRelative(1) },
}

-- and finally, return the configuration to wezterm
return config
