local ok, devcontainer = pcall(require, "devcontainer.status")
if not ok then
	return nil
end

local M = {}

M.status = function()
	if not ok then
		return
	end
	local build_status_last = devcontainer.find_build({ running = true })
	local status = ""
	if build_status_last then
		local build_lines = build_status_last.commands_run
		local command_info = build_lines[#build_lines]
		local command_status_line = ""
		if command_info then
			command_status_line = "(" .. string.sub(command_info, 0, 50)
			if string.len(command_info) > 50 then
				command_status_line = command_status_line .. "..."
			end
			command_status_line = command_status_line .. ")"
		end
		status = status
			.. "["
			.. (build_status_last.current_step or "")
			.. "/"
			.. (build_status_last.step_count or "")
			.. "]"
			.. command_status_line
	end
	return status
end

return M
