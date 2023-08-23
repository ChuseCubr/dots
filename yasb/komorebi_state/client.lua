#!nvim.exe --clean --headless -l

local SCRIPT_PATH = vim.v.argv[5]
SCRIPT_PATH = vim.fs.normalize(vim.fn.fnamemodify(SCRIPT_PATH, ":h"))
package.path = package.path .. ";" .. SCRIPT_PATH .. "/?.lua"

local pipe_handler = require("utils.pipe-handler")
local settings = require("settings").get_client_settings(vim.v.argv)
local uv = vim.loop

local function main()
	pipe_handler.create_client({
		pipe_name = settings.pipe_name,
		query = settings.command,
		default = settings.default,
	})

	uv.run("default")
end

main()
