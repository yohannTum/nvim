local keymap = vim.api.nvim_set_keymap
local function optsdesc(desc)
	return { desc = desc, noremap = true, silent = true }
end
local opts = { noremap = true, silent = true }

return {
	'ThePrimeagen/harpoon',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function ()
		keymap("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", optsdesc("Add harpoon file"))
		keymap("n", "<leader>e", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", optsdesc("Harpoon menu"))

		keymap("n", "<A-h>", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
		keymap("n", "<A-t>", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
		keymap("n", "<A-n>", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
		keymap("n", "<A-s>", ":lua require('harpoon.ui').nav_file(4)<CR>", opts)
		keymap("n", "<A-d>", ":lua require('harpoon.ui').nav_file(5)<CR>", opts)
	end,
}
