#!nvim.exe --clean --headless -l

local uv = vim.loop

local PIPE_NAME = "komorebi_status"
local QUERY = "stack"
local DEFAULT = {
	label = "",
	label_alt = "",
}

for _, v in ipairs(vim.v.argv) do
	local path, _query, c

	path, c = string.gsub(v, "%-%-pipe=", "")
	if c == 1 then
		PIPE_NAME = path
		goto continue
	end

	_query, c = string.gsub(v, "%-%-query=", "")
	if c == 1 then
		QUERY = _query
	end

	::continue::
end

local PIPE_PATH = "\\\\.\\pipe\\" .. PIPE_NAME

local function assert(value, _)
	if value then
		return value
	end
	io.write(vim.json.encode(DEFAULT))
	os.exit(0)
end

local client = assert(uv.new_pipe(false))
client:connect(PIPE_PATH, function(err)
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

	client:write(QUERY)
end)

uv.run("default")
