#!nvim.exe --clean --headless -l

-- settings
local DISPLAY = { "floating", "stacked", "monocle", "maximized" }
local LABELS = {
	floating = {
		label = "",
		label_alt = "",
	},
	stacked = {
		label = "󱟱",
		label_alt = "󱟱",
	},
	monocle = {
		label = "󰘖",
		label_alt = "󰘖",
	},
	maximized = {
		label = "󰁌",
		label_alt = "󰁌",
	},
	none = {
		label = "",
		label_alt = "",
	},
}

local PARAMS = {
	input_pipe = "string",
	output_pipe = "string",
}

local SCRIPT_PATH = vim.v.argv[5]
SCRIPT_PATH = vim.fs.normalize(vim.fn.fnamemodify(SCRIPT_PATH, ":h"))
package.path = package.path .. ";" .. SCRIPT_PATH .. "/?.lua"

local server = require("server-factory")
local active = require("active")
local cli = require("cli")
local uv = vim.loop

local INPUT_PIPE = "komorebi_listener"
local OUTPUT_PIPE = "komorebi_status"
local notif

local function receive(_, chunk)
	notif = assert(vim.json.decode(chunk))
end

local function reply(client, _)
	local status = active.get_status(notif.state)
	local data = {
		label = "",
		label_alt = "",
	}

	for _, v in ipairs(DISPLAY) do
		if status[v] then
			data.label = data.label .. " " .. LABELS[v].label
			data.label_alt = data.label_alt .. " " .. LABELS[v].label_alt
		end
	end

	client:write(vim.json.encode(data))
end

-- if you want only 1 thing
local function reply_query(client, query)
	local success, status = pcall(active[query], notif.state)
	local data
	if success and status then
		data = LABELS[query]
	else
		data = LABELS["none"]
	end

	client:write(vim.json.encode(data))
	status = nil
end

local function main()
	local args = cli.parse(vim.v.argv, PARAMS)
	if args.input_pipe then
		INPUT_PIPE = args.input_pipe
	end
	if args.output_pipe then
		OUTPUT_PIPE = args.output_pipe
	end

	server.create_server({
		pipe_name = INPUT_PIPE,
		callback = receive,
		prerun = function()
			io.write("Listening for Komorebi events at: ", INPUT_PIPE, "\n")
			io.popen("komorebic subscribe " .. INPUT_PIPE)
		end,
	})

	server.create_server({
		pipe_name = OUTPUT_PIPE,
		callback = reply,
		prerun = function()
			io.write("Outputting status to: ", OUTPUT_PIPE, "\n")
		end,
	})

	uv.run("default")
end

main()
