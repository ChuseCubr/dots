local M = {}

function M.get_status(state)
	local status = {
		floating = false,
		stacked = false,
		monocle = false,
		maximized = false,
	}

	local monitor = state.monitors.elements[state.monitors.focused + 1]
	local workspace = monitor.workspaces.elements[monitor.workspaces.focused + 1]

	if workspace.floating_windows ~= vim.NIL and #workspace.floating_windows > 0 then
		status.floating = true
	end

	if #workspace.containers.elements > 0 then
		local container = workspace.containers.elements[workspace.containers.focused + 1]
		if container and #container.windows.elements > 1 then
			status.stacked = true
		end
	end

	if workspace.monocle_container ~= vim.NIL then
		status.monocle = true
	end

	if workspace.maximized_window ~= vim.NIL then
		status.maximized = true
	end

	return status
end

-- alternatives for individual status
function M.get_workspace(state)
	local monitor = state.monitors.elements[state.monitors.focused + 1]
	local workspace = monitor.workspaces.elements[monitor.workspaces.focused + 1]
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

function M.stacked(state)
	local workspace = M.get_workspace(state)
	local container = workspace.containers.elements[workspace.containers.focused + 1]
	return #container.windows.elements > 1
end

return M
