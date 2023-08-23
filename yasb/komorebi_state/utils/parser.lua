local M = {}

function M.boolean(val, name)
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

function M.parse_args(argv, params)
	assert(argv)
	assert(params)

	local args = {}

	for _, arg in ipairs(argv) do
		for param_name, type in pairs(params) do
			local param = "--" .. param_name .. "="
			param, _ = string.gsub(param, "_", "%%%-")
			local val, c = string.gsub(arg:lower(), param:lower(), "")
			if c == 1 then
				args[param_name] = M[type](val, param_name)
				break
			end
		end
	end

	return args
end

function M.parse_settings(argv, settings)
	local args = M.parse_args(argv, settings.params)
	for k, arg in pairs(args) do
		if arg then
			settings[k] = arg
		end
	end

	return settings
end

return M
