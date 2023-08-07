#!nvim.exe --clean --headless -l

local uv = vim.loop

local SCRIPT_PATH = vim.v.argv[5]
SCRIPT_PATH = vim.fs.normalize(vim.fn.fnamemodify(SCRIPT_PATH, ":h"))
package.path = package.path .. ";" .. SCRIPT_PATH .. "/?.lua"

local server = require("server-factory")
local active = require("active")
local notif

local INPUT_PIPE = "komorebi_listener"
local OUTPUT_PIPE = "komorebi_status"

local function receive(_, chunk)
	notif = assert(vim.json.decode(chunk))
end

local function reply(client, query)
	local labels = {
		stack = {
			label = "󱟱 ",
			label_alt = "󱟱 ",
		},
		monocle = {
			label = " ",
			label_alt = " ",
		},
		maximized = {
			label = " ",
			label_alt = " ",
		},
		floating = {
			label = " ",
			label_alt = " ",
		},
		none = {
			label = "",
			label_alt = "",
		},
	}

	local success, status = pcall(active[query], notif.state)
	local data
	if success and status then
		data = labels[query]
	else
		data = labels["none"]
	end

	client:write(vim.json.encode(data))
	status = nil
end

local function main()
	for _, v in ipairs(vim.v.argv) do
		local pipe, c

		pipe, c = string.gsub(v, "%-%-input%-pipe=", "")
		if c == 1 then
			INPUT_PIPE = pipe
			goto continue
		end

		pipe, c = string.gsub(v, "%-%-output%-pipe=", "")
		if c == 1 then
			OUTPUT_PIPE = pipe
		end

		::continue::
	end

	server.create_server({
		pipe_name = INPUT_PIPE,
		callback = receive,
		komorebi = true,
	})

	server.create_server({
		pipe_name = OUTPUT_PIPE,
		callback = reply,
	})

	uv.run("default")
end

main()
