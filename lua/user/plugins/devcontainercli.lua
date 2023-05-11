local status, devcontainercli = pcall(require, "devcontainercli")
if not status then
	-- print("devcontainercli module not present")
	return nil
end

devcontainercli.setup()
