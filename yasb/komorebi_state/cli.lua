#!nvim.exe --clean --headless -l

local M = {}

function M.bool(val, name)
	local lookup = {
		["true"] = true,
		["1"] = true,
		["false"] = false,
		["0"] = false,
	}

	assert(type(lookup[val]) == "boolean", name .. " is not a boolean")
	return lookup[val]
end

function M.string(val, _)
	return val
end

function M.number(val, name)
	return assert(tonumber(val), name .. " is not a number")
end

function M.parse(args, params)
	assert(args)
	assert(params)

	local parsed = {}

	for _, arg in ipairs(args) do
		for param_name, type in pairs(params) do
			local param = "--" .. param_name .. "="
			param, _ = string.gsub(param, "_", "%%%-")
			local val, c = string.gsub(arg:lower(), param:lower(), "")
			if c == 1 then
				parsed[param_name] = M[type](val, param_name)
				break
			end
		end
	end

	return parsed
end

vim.print(M.parse(vim.v.argv, { PIPE_NAME = "string" }))

return M
