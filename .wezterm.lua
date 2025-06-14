local wezterm = require("wezterm")

return {
	window_decorations = "RESIZE",
	enable_tab_bar = false,
	window_background_opacity = 0.75,
	macos_window_background_blur = 10,
	max_fps = 60,

	font = wezterm.font("Hack Nerd Font"),
	font_size = 18,
	font_rules = {
		{
			intensity = "Normal",
			font = wezterm.font("Hack Nerd Font", {
				weight = "Regular",
				stretch = "Normal",
				style = "Normal",
			}),
		},
	},

	-- Custom Color Scheme: Solarized Osaka
	colors = {
		foreground = "#839395",
		background = "#001419",
		cursor_bg = "#839395",
		cursor_border = "#839395",
		cursor_fg = "#001419",
		selection_bg = "#1a6397",
		selection_fg = "#839395",

		ansi = {
			"#001014",
			"#db302d",
			"#849900",
			"#b28500",
			"#268bd3",
			"#d23681",
			"#29a298",
			"#9eabac",
		},
		brights = {
			"#001419",
			"#db302d",
			"#849900",
			"#b28500",
			"#268bd3",
			"#d23681",
			"#29a298",
			"#839395",
		},

		tab_bar = {
			inactive_tab_edge = "#002c38",
			background = "#191b28",

			active_tab = {
				fg_color = "#268bd3",
				bg_color = "#001419",
			},
			inactive_tab = {
				fg_color = "#063540",
				bg_color = "#002c38",
			},
			inactive_tab_hover = {
				fg_color = "#268bd3",
				bg_color = "#002c38",
			},
			new_tab = {
				fg_color = "#268bd3",
				bg_color = "#191b28",
			},
			new_tab_hover = {
				fg_color = "#002c38",
				bg_color = "#268bd3",
			},
		},
	},
}
