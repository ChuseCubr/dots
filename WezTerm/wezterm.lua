local wezterm = require("wezterm")
local colors = require("lua/rose-pine").colors()
local window_frame = require("lua/rose-pine").window_frame()

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.line_height = 1.1
config.font = wezterm.font("FantasqueSansM Nerd Font Mono")
config.font_size = 16
config.colors = colors
config.window_frame = window_frame

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
