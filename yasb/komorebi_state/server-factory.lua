#!nvim.exe --clean --headless -l

local M = {}
local uv = vim.loop

function M.create_server(args)
	local pipe_path = "\\\\.\\pipe\\" .. args.pipe_name

	local server = uv.new_pipe(false)
	assert(server, "Failed to create server")

	local _, err, _ = server:bind(pipe_path)
	assert(not err, err)

	server:listen(128, function(err)
		assert(not err, err)
		local client = uv.new_pipe(false)
		assert(client, "Failed to create client")
		server:accept(client)
		client:read_start(function(err, chunk)
			assert(not err, err)
			if chunk then
				args.callback(client, chunk)
			else
				client:shutdown()
				client:close()
			end
		end)
	end)

	if args.komorebi then
		io.write("Listening for Komorebi events at: ", args.pipe_name, "\n")
		io.popen("komorebic subscribe " .. args.pipe_name)
	else
		io.write("Outputting status to: ", args.pipe_name, "\n")
	end
end

return M
