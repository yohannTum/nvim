local neogit_ok, neogit = pcall(require, 'neogit')
if not neogit_ok then return end

neogit.setup {}

-- keymap("n", "<leader>gdh", ":diffget /2|diffupdate<CR>", optsdesc("diffget left"))
-- keymap("n", "<leader>gdl", ":diffget /3|diffupdate<CR>", optsdesc("diffget right"))
