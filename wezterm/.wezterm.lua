local wezterm = require("wezterm")

return {
	window_decorations = "RESIZE",
	enable_tab_bar = false,
	window_background_opacity = 0.75,
	macos_window_background_blur = 10,

	color_scheme = "tokyonight_night",
	max_fps = 120,

	font = wezterm.font("PlemolJP Console NF"),
	font_size = 18,

	font_rules = {
		{
			italic = true,
			font = wezterm.font("PlemolJP Console NF", { italic = true }),
		},
	},
}
