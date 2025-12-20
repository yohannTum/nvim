-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	spec = {
		-- import your plugins
		{ import = 'plugins' }
	},
	change_detection = {
		notify = false
	}
})

local keymap = vim.api.nvim_set_keymap
local function optsdesc(desc)
	return { desc = desc, noremap = true, silent = true }
end

keymap("n", "<leader>r", ":Lazy reload drag-window.nvim<CR>", optsdesc("Lazy reload drag-window.nvim"))
