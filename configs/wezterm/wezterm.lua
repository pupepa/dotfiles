local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("UDEV Gothic NF", { weight = "Bold" })
config.font_size = 15
config.color_scheme = "tokyonight"
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
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.inactive_pane_hsb = {
  hue = 1.0,
  saturation = 0.1,
  brightness = 1.0,
}

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

config.leader = { key = "t", mods = "CTRL", timeout_milliseconds = 2000 }

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

  -- Tab operations
  { key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
  {
    key = ",",
    mods = "LEADER",
    action = wezterm.action.PromptInputLine({
      description = "Enter new tab name",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  { key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
  { key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
  { key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
  { key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
  { key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
  { key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
  { key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
  { key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
  { key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },
  { key = "0", mods = "LEADER", action = wezterm.action.ActivateTab(9) },

  -- Pane operations
  {
    key = "|",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  }, -- split horizontal
  {
    key = "-",
    mods = "LEADER",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  }, -- split vertical
  { key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.AdjustPaneSize({ "Left", 1 }), pane)
      window:perform_action(wezterm.action.ActivateKeyTable({ name = "setting_mode", one_shot = false }), pane)
    end),
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.AdjustPaneSize({ "Down", 1 }), pane)
      window:perform_action(wezterm.action.ActivateKeyTable({ name = "setting_mode", one_shot = false }), pane)
    end),
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.AdjustPaneSize({ "Up", 1 }), pane)
      window:perform_action(wezterm.action.ActivateKeyTable({ name = "setting_mode", one_shot = false }), pane)
    end),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.AdjustPaneSize({ "Right", 1 }), pane)
      window:perform_action(wezterm.action.ActivateKeyTable({ name = "setting_mode", one_shot = false }), pane)
    end),
  },
  { key = "{", mods = "LEADER|SHIFT", action = wezterm.action.RotatePanes("CounterClockwise") },
  { key = "}", mods = "LEADER|SHIFT", action = wezterm.action.RotatePanes("Clockwise") },
  { key = "Space", mods = "LEADER", action = wezterm.action.RotatePanes("Clockwise") },

  { key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode }, -- enter copy mode
  { key = "]", mods = "LEADER", action = wezterm.action.PasteFrom("Clipboard") },
}

config.key_tables = {
  setting_mode = {
    { key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
    { key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
    { key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
    { key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

    { key = "Escape", action = "PopKeyTable" },
    { key = "q", action = "PopKeyTable" },
    { key = "c", mod = "CTRL", action = "PopKeyTable" },
  },
}

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
-- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { "h", "j", "k", "l" },
  -- if you want to use separate direction keys for move vs. resize, you
  -- can also do this:
  -- direction_keys = {
  --   move = { 'h', 'j', 'k', 'l' },
  --   resize = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
  -- },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
  -- log level to use: info, warn, error
  log_level = "info",
})

require("edit_scrollback").apply_to_config(config)

return config
