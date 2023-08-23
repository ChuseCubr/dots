#!nvim.exe --clean --headless -l

local arg_parser = require("utils.parser")
local M = {}

local server_settings = {
	input_pipe = "komorebi_listener",
	output_pipe = "komorebi_status",
	display = { "monocle", "maximized", "floating", "stacked" },

	statuses = {
		floating = {
			label = "",
			label_alt = "",
			on_left = "komorebic toggle-float",
			on_right = "",
			on_middle = "",
		},
		stacked = {
			label = "󱟱",
			label_alt = "󱟱",
			on_left = "komorebic cycle-stack next",
			on_right = "komorebic cycle-stack previous",
			on_middle = "komorebic unstack",
		},
		monocle = {
			label = "󰘖",
			label_alt = "󰘖",
			on_left = "komorebic toggle-monocle",
			on_right = "",
			on_middle = "",
		},
		maximized = {
			label = "󰁌",
			label_alt = "󰁌",
			on_left = "komorebic toggle-maximize",
			on_right = "",
			on_middle = "",
		},
	},

	params = {
		input_pipe = "string",
		output_pipe = "string",
	},
}

local client_settings = {
	pipe_name = "komorebi_status",
	command = "get_status",

	default = vim.json.encode({
		label = "",
		label_alt = "",
		on_left = "do_nothing",
		on_right = "do_nothing",
		on_middle = "do_nothing",
	}),

	params = {
		pipe_name = "string",
		command = "string",
	},
}

function M.get_server_settings(argv)
	return arg_parser.parse_settings(argv, server_settings)
end

function M.get_client_settings(argv)
	return arg_parser.parse_settings(argv, client_settings)
end

return M
