local filename = vim.fn.expand("%:t")
if filename:match('_spec%.lua$') then -- for every '*_spec.lua' files
	vim.api.nvim_buf_set_keymap(0, "n", "<leader>tt", "<Plug>PlenaryTestFile", { noremap = false, silent = false, desc = 'Testing this file with the plenary test suite' })
end
