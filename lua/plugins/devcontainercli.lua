-- Don't load the plugin if the directory doesn't exists
if vim.fn.isdirectory(vim.env.HOME .. "/plugins/devcontainercli") == 0 then
	return {}
end

return {
	dir = '~/plugins/devcontainercli',
}
