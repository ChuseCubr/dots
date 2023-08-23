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
					if args.default then
						client:write(args.default)
					else
						client:write("Internal server error:" .. err .. "\n")
					end
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

function M.create_client(args)
	assert(args.pipe_name)
	assert(args.query)

	local pipe_path = "\\\\.\\pipe\\" .. args.pipe_name

	local assert = assert

	if args.default then
		function assert(value, _)
			if value then
				return value
			end
			io.write(args.default)
			os.exit(0)
		end
	end

	local client = assert(uv.new_pipe(false))
	client:connect(pipe_path, function(err)
		assert(not err, err)
		client:read_start(function(err, chunk)
			assert(not err, err)
			if chunk then
				io.write(chunk)
				client:shutdown()
				client:close()
				os.exit(0)
			else
				client:shutdown()
				client:close()
			end
		end)

		client:write(args.query)
	end)
end

return M
