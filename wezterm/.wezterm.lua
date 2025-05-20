local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_background_opacity = 0.75
config.macos_window_background_blur = 10

config.color_scheme = "tokyonight_night"
config.max_fps = 120

config.font = wezterm.font("PlemolJP Console NF")
config.font_size = 18

config.font_rules = {
	{
		italic = true,
		font = wezterm.font("PlemolJP Console NF", { italic = true }),
	},
}

return config
