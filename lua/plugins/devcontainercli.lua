-- Don't load the plugin if the directory doesn't exists
if vim.fn.isdirectory("/home/yohann/plugins/devcontainercli") == 0 then
	return {}
end

return {
	dir = '/home/yohann/plugins/devcontainercli',
}
