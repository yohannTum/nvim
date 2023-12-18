local findfiles = function(preview)
	require('telescope.builtin').find_files({
		-- prompt_title = '###',
		hidden = true,
		preview_cutoff = 1,
		previewer = preview, -- nil or false? wtf...
	})
end

local whichkey_status, whichkey = pcall(require, "which-key")
if whichkey_status then
	whichkey.register({ ["<Leader>/G"] = { name = "Git" } })
	whichkey.register({ ["<Leader>/w"] = { name = "Workspaces" } })
end

return {
	'nvim-telescope/telescope.nvim', tag = '0.1.0',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },

		{ 'nvim-telescope/telescope-symbols.nvim' },
		{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
	},
	keys = {
		{"<Leader>/f", function () findfiles(false) end, desc = "Find Files", noremap = true , silent = true},
		{"<Leader>/F", function () findfiles(nil) end, desc = 'Find Files with preview', noremap = true , silent = true},
		{"<Leader>/g", ":Telescope live_grep<CR>", desc = 'Live Grep', noremap = true , silent = true},
		{"<Leader>/b", ":Telescope buffers<CR>", desc = 'Buffers', noremap = true , silent = true},
		{"<Leader>/h", ":Telescope help_tags<CR>", desc = 'Help Tags', noremap = true , silent = true},
		{"<Leader>/c", ":Telescope commands<CR>", desc = 'Help Tags', noremap = true , silent = true},
		{"<Leader>/Gc", ":Telescope git_commits<CR>", desc = 'Git commits', noremap = true , silent = true},
		{"<Leader>/Gb", ":Telescope git_branches<CR>", desc = 'Git branches', noremap = true , silent = true},
		{"<Leader>/Gs", ":Telescope git_status<CR>", desc = 'Git status', noremap = true , silent = true},
	},
	config = {
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
	}
}
