-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime'

config.font = wezterm.font "TX-02"
config.font_size = 15.0

config.hide_tab_bar_if_only_one_tab = true

wezterm.on('gui-startup', function(_)
  local _, _, window = wezterm.mux.spawn_window({})
  window:gui_window():toggle_fullscreen()
end)

-- KEYS
--
config.keys = {
  {
    key = 'Enter',
    mods = 'CMD',
    action = wezterm.action.ToggleFullScreen,
  },
}

config.colors = {
  -- The default text color
  foreground = "#A5FBFF",
  -- The default background color
  background = "#141D22",

  -- Cursor colors
  cursor_fg = "#141D22", -- Background color when cursor is over a character
  cursor_bg = "#A5FBFF", -- The cursor color

  -- Selection colors
  selection_fg = "#A5FBFF",
  selection_bg = "#1e2628",

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = "#3a4c4e",

  -- The 16 terminal colors
  ansi = {
    "#141D22", -- black (0)
    "#dd513c", -- red (1)
    "#3df2ad", -- green (2)
    "#ffb78a", -- yellow (3)
    "#34A2DF", -- blue (4)
    "#eb78c3", -- magenta (5)
    "#4DDCFF", -- cyan (6)
    "#A5FBFF", -- white (7)
  },
  brights = {
    "#3a4c4e", -- bright black (8)
    "#dd513c", -- bright red (9)
    "#3df2ad", -- bright green (10)
    "#ffb78a", -- bright yellow (11)
    "#34A2DF", -- bright blue (12)
    "#eb78c3", -- bright magenta (13)
    "#4DDCFF", -- bright cyan (14)
    "#A5FBFF", -- bright white (15)
  },
}

-- and finally, return the configuration to wezterm
return config
