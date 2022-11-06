local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- g = Gitfugitive (git commands)
-- noremap <leader>gs :Gstatus<cr>
keymap("n", "<leader>gs", "Gstatus<CR>", opts)
