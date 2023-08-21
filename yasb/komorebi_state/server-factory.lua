#!nvim.exe --clean --headless -l

local M = {}
local uv = vim.loop

function M.create_server(args)
	assert(args.pipe_name)
	assert(args.callback)

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
				local success, err = pcall(args.callback, client, chunk)
				if not success then
					client:write("Internal server error:" .. err .. "\n")
				end
			else
				client:shutdown()
				client:close()
			end
		end)
	end)

	if args.prerun then
		args.prerun()
	end
end

return M
