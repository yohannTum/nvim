return {
	'junegunn/fzf',
	tag = '0.42.0',
	keys = {
		{ "<Leader>/z", ":FZF<CR>", desc = "Fuzzy find file", silent = true, noremap = true },
		{ "<Leader>/Z", ":FZF --exact<CR>", desc = "Fuzzy find file exact matching", silent = true, noremap = true }
	},
	config = function ()
		local group = vim.api.nvim_create_augroup("user_setup_fzf", { clear = true })

		local load_fzf_options = function()
			vim.env.FZF_DEFAULT_OPTS = '--reverse'
			vim.g['fzf_layout'] = { window = { width = 0.8, height = 0.8 } }
		end
		vim.api.nvim_create_autocmd("VimEnter", { callback = load_fzf_options, group = group })
	end
}
