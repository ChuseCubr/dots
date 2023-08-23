#!nvim.exe --clean --headless -l

local active_window = require("utils.active-window")
local M = {}

function M.get_status(state)
	state.status = active_window.get_status(state.notif.state)
	local data = {
		label = "",
		label_alt = "",
		on_left = "",
		on_right = "",
		on_middle = "",
	}

	for _, v in ipairs(state.settings.display) do
		if state.status[v] then
			data.label = data.label .. " " .. state.settings.statuses[v].label
			data.label_alt = data.label_alt .. " " .. state.settings.statuses[v].label_alt
		end
	end

	for _, v in ipairs(state.settings.display) do
		if state.status[v] then
			data.on_left = state.settings.statuses[v].on_left
			data.on_right = state.settings.statuses[v].on_right
			data.on_middle = state.settings.statuses[v].on_middle
			break
		end
	end

	state.client:write(vim.json.encode(data))
end

return M
