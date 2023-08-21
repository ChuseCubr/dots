#!nvim.exe --clean --headless -l

local PIPE_NAME = "komorebi_status"
local COMMAND = "ping"

local PARAMS = {
	pipe_name = "string",
	command = "string",
}

local DEFAULT = vim.json.encode({
	label = "",
	label_alt = "",
})

local SCRIPT_PATH = vim.v.argv[5]
SCRIPT_PATH = vim.fs.normalize(vim.fn.fnamemodify(SCRIPT_PATH, ":h"))
package.path = package.path .. ";" .. SCRIPT_PATH .. "/?.lua"

local client = require("client-factory")
local cli = require("cli")
local uv = vim.loop

local function main()
	local args = cli.parse(vim.v.argv, PARAMS)
	if args.pipe_name then
		PIPE_NAME = args.pipe_name
	end
	if args.command then
		COMMAND = args.command
	end

	client.create_client({
		pipe_name = PIPE_NAME,
		query = COMMAND,
		default = DEFAULT,
	})

	uv.run("default")
end

main()
