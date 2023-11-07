local wezterm = require('wezterm')
local colors = require('lua/rose-pine').colors()
local window_frame = require('lua/rose-pine').window_frame()

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.window_frame = window_frame
config.colors = colors
config.line_height = 1.0
config.font_size = 14
config.font = wezterm.font({
	family = 'Maple Mono NF',
	harfbuzz_features = {
		'cv01',
		'cv02',
		'cv04',
		'ss01',
		'ss03',
		'ss04',
		'ss04',
	}
})

config.keys = {
	{
		key = 'P',
		mods = 'CTRL',
		action = wezterm.action.ActivateCommandPalette,
	},
}

config.launch_menu = {}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
	config.default_prog = { 'C:/Program Files/PowerShell/7/pwsh.exe', '-NoLogo' }
	table.insert(config.launch_menu, {
		label = 'cmd',
		args = { 'cmd.exe' },
	})
end

return config
