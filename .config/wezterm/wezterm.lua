-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.font_size = 10.0
config.use_ime = true --IMEで日本語を入力できるようにする
config.window_background_opacity = 0.80 --背景の透過
config.macos_window_background_blur = 20 --ぼかし
config.hide_tab_bar_if_only_one_tab = true --タブが一つしかない時に非表示にする
config.show_new_tab_button_in_tab_bar = false --タブバーの+を消す
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}
config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'UnderTheSea'

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
   local background = "#5c6d74"
   local foreground = "#FFFFFF"

   if tab.is_active then
     background = "#ae8b2d"
     foreground = "#FFFFFF"
   end

   local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

   return {
     { Background = { Color = background } },
     { Foreground = { Color = foreground } },
     { Text = title },
     { Text = SOLID_LEFT_ARROW },
     { Text = SOLID_RIGHT_ARROW },
   }
 end)

return config
