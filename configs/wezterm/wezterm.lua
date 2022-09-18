local wezterm = require("wezterm");

return {
  font = wezterm.font("UDEV Gothic NF"),
  font_size = 13,
  color_scheme = "nightfox",
  use_ime = true,
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
