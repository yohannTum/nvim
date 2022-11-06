local group = vim.api.nvim_create_augroup("user_setup_fzf", { clear = true })

-- ****************** options ****************** --
local load_fzf_options = function()
	if packer_plugins and packer_plugins['fzf'] then
		vim.env.FZF_DEFAULT_OPTS = '--reverse'
		vim.g['fzf_layout'] = { window = { width = 0.8, height = 0.8 } }
	end
end
vim.api.nvim_create_autocmd("VimEnter", { callback = load_fzf_options, group = group })
