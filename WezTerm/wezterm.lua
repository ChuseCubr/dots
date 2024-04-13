local wezterm = require("wezterm")
local colors = require("lua/rose-pine").colors()
-- local colors = wezterm.color.load_scheme("vscode-dark.toml")
local window_frame = require("lua/rose-pine").window_frame()

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local font_configs = {
	iosevka = {
		config = {
			family = "Iosevka NFM Medium",
			harfbuzz_features = {
				-- "calt",
				-- "dlig",
			},
		},
		size = 16,
		line_height = 1.0,
	},
	monaspace = {
		config = {
			family = "MonaspiceNe NFM",
			harfbuzz_features = {
				"ss01",
				"ss02",
				"ss03",
				"ss04",
				"ss05",
				"ss06",
				"ss07",
				"ss08",
				"dlig",
				"calt",
			},
		},
		size = 14,
		line_height = 1.0,
	},
	maple_mono = {
		config = {
			family = "Maple Mono NF",
			harfbuzz_features = {
				"cv01", -- disable @#$%... gaps
				"cv02", -- curvier i
				-- "cv03", -- alternative a
				"cv04", -- alternative @
				-- "ss01", -- equals
				-- "ss02", -- [] status stuff
				-- "ss03", -- __
				-- "ss04", -- >= and <=
				-- "ss05", -- {{ and }}
			},
		},
		size = 14,
		line_height = 1.0,
	},
	fira_code = {
		config = {
			family = "FiraCode Nerd Font Mono",
			harfbuzz_features = {
				-- variants
				"cv01", -- a
				"cv02", -- g
				"cv06", -- 03-06: i
				-- "cv07", -- 07-10: l
				-- "ss01", -- r
				"zero", -- cv11-13: 0
				"cv14", -- 3
				-- "onum", -- num elevations
				-- "cv17", -- ~
				-- "ss05", -- @
				"ss04", -- $
				-- "cv18", -- %
				"ss03", -- &
				-- "cv15", -- 15-16: *
				-- "cv31", -- ()
				-- "cv29", -- {}
				"cv30", -- |

				-- ligatures
				-- "ss02", -- <= >=
				-- "cv19", -- 19-20: <=
				-- "cv23", -- >=
				-- "cv21", -- 21-22: =<
				-- "ss08", -- equality
				-- "cv24", -- /=
				-- "ss09", -- bitshift assignment
				-- "cv25", -- .-
				-- "cv26", -- :-
				-- "cv32", -- .=
				-- "cv27", -- []
				-- "cv28", -- {. .}
				-- "ss06", -- \\
				-- "ss07", -- =~ !~
				-- "ss10", -- ftlij
			},
		},
		size = 14,
		line_height = 1.0,
	},
}

config.force_reverse_video_cursor = true
config.window_frame = window_frame
config.colors = colors
config.window_background_opacity = 0.9

local font_config = font_configs.iosevka
config.font_size = font_config.size
config.line_height = font_config.line_height
config.font = wezterm.font(font_config.config)

config.keys = {
	{
		key = "P",
		mods = "CTRL",
		action = wezterm.action.ActivateCommandPalette,
	},
}

config.launch_menu = {}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe", "-NoLogo" }
	table.insert(config.launch_menu, {
		label = "cmd",
		args = { "cmd.exe" },
	})
end

return config
