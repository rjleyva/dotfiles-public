local wezterm = require("wezterm")

return {
	window_decorations = "RESIZE",
	enable_tab_bar = false,
	window_background_opacity = 0.75,
	macos_window_background_blur = 10,
	color_scheme = "Solarized Dark - Patched",
	max_fps = 60,
	font = wezterm.font("FiraCode Nerd Font"),
	font_size = 18,
	font_rules = {
		{
			intensity = "Normal",
			font = wezterm.font("FiraCode Nerd Font", { weight = "Light", stretch = "Normal", style = "Normal" }),
		},
	},
}
