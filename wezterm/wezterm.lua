local wezterm = require("wezterm")

return {
	-- term = "wezterm",
	font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Regular" }),
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font({
				family = "JetBrainsMono Nerd Font",
				weight = "ExtraBold",
			}),
		},
	},
	-- font_antialias = "Subpixel",
	font_size = 13,
	line_height = 1,
	bold_brightens_ansi_colors = true,
	color_scheme = "3024",
	window_background_opacity = 0.9,
	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = true,
	initial_rows = 70,
	initial_cols = 280,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_close_confirmation = "NeverPrompt",
}
