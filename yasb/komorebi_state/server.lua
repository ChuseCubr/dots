#!nvim.exe --clean --headless -l

local SCRIPT_PATH = vim.v.argv[5]
SCRIPT_PATH = vim.fs.normalize(vim.fn.fnamemodify(SCRIPT_PATH, ":h"))
package.path = package.path .. ";" .. SCRIPT_PATH .. "/?.lua"

local pipe_handler = require("utils.pipe-handler")
local commands = require("utils.commands")
local settings = require("settings").get_server_settings(vim.v.argv)
local uv = vim.loop

local state = {
	settings = settings,
	notif = {},
	client = {},
	status = {},
}

local function listener(_, chunk)
	state.notif = assert(vim.json.decode(chunk))
end

local function reply(client, command)
	state.client = client
	commands[command](state)
end

local function main()
	pipe_handler.create_server({
		pipe_name = settings.input_pipe,
		callback = listener,
		prerun = function()
			io.write("Listening for Komorebi events at: ", settings.input_pipe, "\n")
			io.popen("komorebic subscribe " .. settings.input_pipe)
		end,
	})

	pipe_handler.create_server({
		pipe_name = settings.output_pipe,
		callback = reply,
		prerun = function()
			io.write("Outputting status to: ", settings.output_pipe, "\n")
		end,
	})

	uv.run("default")
end

main()
