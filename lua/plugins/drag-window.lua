
-- Don't load the plugin if the directory doesn't exists
if vim.fn.isdirectory(vim.env.HOME .. "/plugins/drag-window.nvim") == 0 then
	print("drag-window.nvim plugin not found")
	return {}
end


return {
	{
		dir = "~/plugins/drag-window.nvim",
		config = function()
			require("drag-window")
		end
	}
}
