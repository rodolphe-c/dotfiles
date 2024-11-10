local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Tokyo Night"
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 15.0

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_background_opacity = 0.99
config.window_decorations = "RESIZE"
config.enable_tab_bar = false

return config
