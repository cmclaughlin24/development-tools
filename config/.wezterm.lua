local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("SpaceMono Nerd Font")
config.font_size = 14

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

config.color_scheme = "Tokyo Night"

return config
