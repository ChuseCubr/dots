#!nvim.exe --clean --headless -l

local M = {}
local uv = vim.loop

function M.create_client(args)
	assert(args.pipe_name)
	assert(args.query)
	assert(args.default)

	local pipe_path = "\\\\.\\pipe\\" .. args.pipe_name

	local function assert(value, _)
		if value then
			return value
		end
		io.write(args.default)
		os.exit(0)
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
