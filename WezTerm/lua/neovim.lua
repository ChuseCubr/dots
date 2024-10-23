local M = {}
local dark_palette = {
  blue = "#004c73",
  cyan = "#007373",
  green = "#005523",
  grey1 = "#07080d",
  grey2 = "#14161b",
  grey3 = "#2c2e33",
  grey4 = "#4f5258",
  magenta = "#470045",
  red = "#590008",
  yellow = "#6b5300",
}

local light_palette = {
  blue = "#a6dbff",
  cyan = "#8cf8f7",
  green = "#b3f6c0",
  grey1 = "#eef1f8",
  grey2 = "#e0e2ea",
  grey3 = "#c4c6cd",
  grey4 = "#9b9ea4",
  magenta = "#ffcaff",
  red = "#ffc0b9",
  yellow = "#fce094",
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
