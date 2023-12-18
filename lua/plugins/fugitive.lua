local keymap = vim.api.nvim_set_keymap

local function optsdesc(desc)
	return { desc = desc, noremap = true, silent = true }
end

return {
	'tpope/vim-fugitive', -- TODO: keymap
	config = function ()

		-- TODO: attach buffer when git is available
		local whichkey_status, whichkey = pcall(require, "which-key")
		if whichkey_status then
			whichkey.register({ ["<Leader>g"] = { name = "Git" } --[[, { buffer = bufnr }]]})
		end

		-- local util = require 'lspconfig.util'
		-- print(vim.inspect(util.find_git_ancestor("/tmp/totogit2/toto1/test1.md"))) -- WORKING!!!
		-- print(vim.inspect(util.root_pattern(".git")("/tmp/totogit2/toto1/"))) -- WORKING!!
		-- vim.pretty_print(util.path.exists("lua/user/plugins/fugitive.lua")) -- ça marche!!!

		-- ":Git mergetool<CR>:Gvdiffsplit!<CR>]c"

		keymap("n", "<leader>gs", ":Git status<CR>", optsdesc("git status"))
		keymap("n", "<leader>gl", ":Git log<CR>", optsdesc("git log"))
	end
}
