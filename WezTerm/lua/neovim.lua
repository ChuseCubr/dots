local M = {}

local dark_palette = {
	blue = "#005078",
	cyan = "#007676",
	green = "#015825",
	grey1 = "#0a0b10",
	grey2 = "#1c1d23",
	grey3 = "#2c2e33",
	grey4 = "#4f5258",
	magenta = "#4c0049",
	red = "#5e0009",
	yellow = "#6e5600",
}

local light_palette = {
	blue = "#9fd8ff",
	cyan = "#83efef",
	green = "#aaedb7",
	grey1 = "#ebeef5",
	grey2 = "#d7dae1",
	grey3 = "#c4c6cd",
	grey4 = "#9b9ea4",
	magenta = "#ffc3fa",
	red = "#ffbcb5",
	yellow = "#f4d88c",
}

local active_tab = {
	bg_color = dark_palette.grey4,
	fg_color = light_palette.grey2,
}

local inactive_tab = {
	bg_color = dark_palette.grey2,
	fg_color = dark_palette.grey4,
}

function M.colors()
	return {
		foreground = light_palette.grey2,
		background = dark_palette.grey2,
		cursor_bg = dark_palette.grey4,
		cursor_border = dark_palette.grey4,
		cursor_fg = light_palette.grey2,
		selection_bg = dark_palette.grey4,
		selection_fg = light_palette.grey2,

		ansi = {
			light_palette.grey4,
			light_palette.red,
			light_palette.green,
			light_palette.yellow,
			light_palette.blue,
			light_palette.magenta,
			light_palette.cyan,
			light_palette.grey2,
		},

		brights = {
			light_palette.grey4,
			light_palette.red,
			light_palette.green,
			light_palette.yellow,
			light_palette.blue,
			light_palette.magenta,
			light_palette.cyan,
			light_palette.grey2,
		},

		tab_bar = {
			background = dark_palette.grey2,
			active_tab = active_tab,
			inactive_tab = inactive_tab,
			inactive_tab_hover = active_tab,
			new_tab = inactive_tab,
			new_tab_hover = active_tab,
			inactive_tab_edge = dark_palette.grey4,
		},
	}
end

function M.window_frame() -- (Fancy tab bar only)
	return {
		active_titlebar_bg = dark_palette.grey2,
		inactive_titlebar_bg = dark_palette.grey2,
	}
end

return M
