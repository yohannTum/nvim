local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then return end

local keymap = vim.api.nvim_set_keymap

local function optsdesc(desc)
	return { desc = desc, noremap = true, silent = true }
end

telescope.setup({
	defaults = {
		-- :h telescope.defaults.layout_strategy
		layout_strategy = 'horizontal',
		sorting_strategy = 'ascending',
		color_devicons = true,
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = "  ",
		layout_config = {
			prompt_position = "top"
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			-- my options :
			"--smart-case",
			-- "-u",
		}
	},
})

_G.FindFiles = function(preview)
	require('telescope.builtin').find_files({
		-- prompt_title = '###',
		hidden = true,
		preview_cutoff = 1,
		previewer = preview, -- nil or false? wtf...
	})
end

keymap("n", "<Leader>/f", ":lua FindFiles(false)<CR>", optsdesc('Find Files'))
keymap("n", "<Leader>/F", ":lua FindFiles(nil)<CR>", optsdesc('Find Files with preview'))
keymap("n", "<Leader>/g", ":Telescope live_grep<CR>", optsdesc('Live Grep'))
keymap("n", "<Leader>/b", ":Telescope buffers<CR>", optsdesc('Buffers'))
keymap("n", "<Leader>/h", ":Telescope help_tags<CR>", optsdesc('Help Tags'))
keymap("n", "<Leader>/c", ":Telescope commands<CR>", optsdesc('Help Tags'))
