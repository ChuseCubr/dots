local M = {}

-- Get focused monitor/workspace/container using focused index queries.
function M.get_focused(object, name)
	local collection = object[name .. "s"].elements
	local collection_not_empty = #collection > 0
	assert(collection_not_empty, name .. " collection is empty")

	if #collection == 1 then
		return collection[1]
	end

	local command = "komorebic query focused-" .. name .. "-index"
	local handle = assert(io.popen(command))
	local index = assert(handle:read("*n")) + 1

	return collection[index]
end

function M.get_workspace(state)
	local monitor = M.get_focused(state, "monitor")
	local workspace = M.get_focused(monitor, "workspace")
	return workspace
end

function M.monocle(state)
	local workspace = M.get_workspace(state)
	return workspace.monocle_container ~= vim.NIL
end

function M.maximized(state)
	local workspace = M.get_workspace(state)
	return workspace.maximized_window ~= vim.NIL
end

function M.floating(state)
	local workspace = M.get_workspace(state)
	if workspace.floating_windows == vim.NIL then
		return false
	end
	return #workspace.floating_windows > 0
end

function M.stack(state)
	local workspace = M.get_workspace(state)
	local container = M.get_focused(workspace, "container")
	return #container.windows.elements > 1
end

return M
