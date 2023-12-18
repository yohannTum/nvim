-- keymap("n", "<leader>gdh", ":diffget /2|diffupdate<CR>", optsdesc("diffget left"))
-- keymap("n", "<leader>gdl", ":diffget /3|diffupdate<CR>", optsdesc("diffget right"))

return {
	'TimUntersberger/neogit',
	commit = 'c1a2a1aa5b4fd774dc26c53f7f256f1320c0ff15',
	dependencies = {
		"nvim-lua/plenary.nvim",         -- required
		"nvim-telescope/telescope.nvim", -- optional
		-- "sindrets/diffview.nvim",        -- optional
	},
	config = true
}
