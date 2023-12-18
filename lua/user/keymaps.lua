local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

local function opts_desc (desc)
	return { noremap = true, silent = true, desc = desc }
end

-- TODO: https://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work (save with sudo priviledges)

-- Modes
--	normal_mode = "n"
--	insert_mode = "i"
--	visual_mode = "v"
--	visual_block_mode = "x"
--	term_mode = "t"
--	command_mode = "c"

-- Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts) -- This will erase which-key config when hot reloading!!
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- local list
keymap("n", "L", ":lnext<CR>", opts)
keymap("n", "H", ":lprev<CR>", opts)

-- quick fix list
keymap("n", "<C-l>", ":cnext<CR>", opts)
keymap("n", "<C-h>", ":cprev<CR>", opts)

vim.cmd([[tnoremap <Esc> <C-\><C-n>]])
-- keymap("t", "<Esc>", "<C-\><C-n>", opts) -- error?

--[[
vim script for ordering registers if needed??
https://vi.stackexchange.com/questions/26818/vim-not-storing-numbered-registers
]]
-- function! SaveLastReg()
--     if v:event['regname']==""
--         if v:event['operator']=='y'
--             for i in range(8,1,-1)
--                 exe "let @".string(i+1)." = @". string(i)
--             endfor
--             if exists("g:last_yank")
--                 let @1=g:last_yank
--             endif
--             let g:last_yank=@"
--         endif
--     endif
-- endfunction
--
-- :autocmd TextYankPost * call SaveLastReg()

-- Copy and paste modified behavior
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
keymap("v", "p", 'p:let @"=@0<CR>', opts) -- not overiding register, only in visual mode
keymap("n", "<leader>p", '"+p', opts) -- paste from system clipboard
keymap("v", "<leader>p", '"+p', opts) -- paste from system clipboard

keymap("n", "<leader>y", '"+y', opts) -- copy into system clipboard
keymap("v", "<leader>y", '"+y', { silent = true, noremap = true, desc = "paste into system clipboard" })
-- keymap("n", "<leader>Y", '"+Y', term_opts)

-- Making it default? and map <leader>d as regular?
-- Other solution : keymap("n", "<leader>d", '"zd', opts)
-- use z register as "important to keep aside"
-- = need to map <leader>p with z register then?
--
-- keymap("n", "<leader>d", '"_d', opts)
-- keymap("v", "<leader>d", '"_d', opts)

-- NORMAL
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Better window navigation
keymap("n", "<Leader>h", "<C-w>h", opts_desc("Window "))
keymap("n", "<Leader>j", "<C-w>j", opts_desc("Window "))
keymap("n", "<Leader>k", "<C-w>k", opts_desc("Window "))
keymap("n", "<Leader>l", "<C-w>l", opts_desc("Window "))
keymap("n", "<Leader>c", "<C-w>c", opts_desc("Window "))
keymap("n", "<Leader>s", "<C-w>s", opts_desc("Window ﲔ"))
keymap("n", "<Leader>v", "<C-w>v", opts_desc("Window ﲖ"))
keymap("n", "<Leader>C", ":tablclose<CR>", opts_desc("tab close "))

-- Stay in indent mode
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

-- Horizontal scroll
keymap("n", "zh", "zH", opts)
keymap("n", "zl", "zL", opts)

-- Vertical navigation
keymap("n", "}", ":keepjumps normal! {<CR>", opts)
keymap("n", "{", ":keepjumps normal! }<CR>", opts)
keymap("x", "}", ":<C-u>keepjumps normal! gv{<CR>", opts)
keymap("x", "{", ":<C-u>keepjumps normal! gv}<CR>", opts)

-- :h api or :h builtin (vim.fn)
BetterCTRL_D = function()
	-- local window = vim.api.nvim_get_current_win()
	local windowHeight = vim.fn.winheight(0)
	local windowHalfHeight = vim.fn.floor(windowHeight / 2)

	local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
	-- line = line + windowHalfHeight - 1
	line = line + windowHalfHeight
	if windowHeight % 2 == 0 then
		line = line - 1
	end
	vim.fn.cursor(line, 0)

	-- center camera with ctrl-e
	-- local relativeCursor = line - windowHeight
	-- print(relativeCursor)
	-- local rowTopWindow, _ = unpack(vim.api.nvim_win_get_position(0))
	-- print(rowTopWindow)
end

BetterCTRL_U = function() -- without having the window to move
	-- local window = vim.api.nvim_get_current_win()
	local windowHeight = vim.fn.winheight(0)
	local windowHalfHeight = vim.fn.floor(windowHeight / 2)

	local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
	-- line = line - windowHalfHeight + 1
	line = line - windowHalfHeight
	if windowHeight % 2 == 0 then
		line = line + 1
	end

	if line < 1 then
		line = 1
	end
	vim.fn.cursor(line, 0)
end

-- Less "glitchy" solution than "<C-d>zz" command
-- when the cursor is positioned at the top of a file
keymap("n", "<A-j>", ":lua BetterCTRL_D()<CR>zz", opts)
keymap("n", "<A-k>", ":lua BetterCTRL_U()<CR>zz", opts)
-- keymap("n", "<A-j>", "<C-d>zz", opts)
-- keymap("n", "<A-k>", "<C-u>zz", opts)
keymap("v", "<A-j>", "10j", opts)
keymap("v", "<A-k>", "10k", opts)

keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Crazy stuff for removing highlights after a search width escape
keymap("n", "<Esc>", ":noh<CR>:echo ''<CR><Esc>", opts)
-- keymap("n", "<Esc>^[", "<Esc>^[", opts)
-- vim.cmd("nnoremap <esc> :noh<return><esc>")
-- vim.cmd("nnoremap <esc>^[ <esc>^[")

-- Buffer keymaps
keymap("n", "<Leader><Leader>bs", ":ls<CR>", opts) -- TODO: not day to day used keymaps = leader * 2 (lsp for example), search...
-- keep <leader>l for ctrl-w_l for example : way faster
-- https://www.youtube.com/watch?v=BdoizYjJHis&ab_channel=chris%40machine

-- Use <Tab> and <S-Tab> to navigate through popup menu (vimscript) (better native C-n and C-p)
-- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

-- VISUAL
-- Move text up and down (not a fan)
-- keymap("v", "<C-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<C-k>", ":m .-2<CR>==", opts)
-- keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
-- keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)
