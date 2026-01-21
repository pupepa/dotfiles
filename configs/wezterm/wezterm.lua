local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("UDEV Gothic NF", { weight = "Bold" })
config.font_size = 15
config.color_scheme = "nightfox"
config.use_ime = true
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

local DEFAULT_OPACITY = 0.85
config.window_background_opacity = DEFAULT_OPACITY
config.window_close_confirmation = "NeverPrompt" -- AlwaysPrompt or NeverPrompt
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false

config.colors = {
  tab_bar = {
    background = "rgba(0, 0, 0, 80%)",

    active_tab = {
      bg_color = "#0c0b0f",
      fg_color = "#bea3c7",
      intensity = "Bold",
      underline = "None",
      italic = false,
      strikethrough = false,
    },

    inactive_tab = {
      bg_color = "#0c0b0f",
      fg_color = "#f8f2f5",
      intensity = "Half",
      underline = "None",
      italic = false,
      strikethrough = false,
    },
  },
}

-- config.leader = {
--   key = "b",
--   mods = "CTRL",
--   timeout_milliseconds = 2000,
-- }

config.keys = {
  {
    key = "O",
    mods = "CTRL|SHIFT",
    -- toggling opacity
    action = wezterm.action_callback(function(window, _)
      local overrides = window:get_config_overrides() or {}
      if overrides.window_background_opacity == DEFAULT_OPACITY then
        overrides.window_background_opacity = 0.1
      elseif overrides.window_background_opacity == 0.1 then
        overrides.window_background_opacity = 1.0
      else
        overrides.window_background_opacity = DEFAULT_OPACITY
      end
      window:set_config_overrides(overrides)
    end),
  },

  {
    key = "x",
    mods = "LEADER",
    action = wezterm.action.QuickSelect,
  },

  { key = "x", mods = "CTRL", action = wezterm.action.ActivateCopyMode },
}

return config
