-- help: options
-- vim.opt.backup = false -- create a backup file

vim.o.completeopt = "menu,menuone,noselect"
-- vim.opt.completopt = { "menuone", "noselect" } -- Keep it? Mostly for cmp

vim.opt.backspace = "indent,eol,start"
vim.opt.background = "dark"
vim.opt.clipboard = "" -- no synchronization between vim and the os clipboard
vim.opt.cursorline = false
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.errorbells = false
vim.opt.expandtab = false
vim.opt.fileencoding = "utf-8"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.laststatus = 3 -- global status bar <3

vim.opt.list = true
-- vim.opt.listchars = { tab = '▸ ', trail = '·' }
-- vim.opt.listchars = { tab = '| ', trail = '·' }
vim.opt.listchars = { tab = ' ', trail = '·' }
-- vim.opt.listchars = { tab = ' ', trail = '·' }

vim.opt.mouse = "a"
vim.opt.number = true -- set number lines
vim.opt.relativenumber = true
vim.opt.scrolloff = 0
vim.opt.showcmd = true
vim.opt.showmode = false -- handled by airline
vim.opt.sidescrolloff = 15
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.o.termguicolors = true
vim.opt.title = true
vim.opt.timeoutlen = 800 -- time in milliseconds for whichkey to popup
vim.opt.wildmenu = true
vim.opt.wrap = false

-- TABS are better than spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4


-- Old vim settings, still usefull?
-- g files colors
vim.cmd("au BufRead,BufNewFile *.g set filetype=antlr3")
vim.cmd("au BufRead,BufNewFile *.g4 set filetype=antlr4")

-- colors
-- vim.cmd("set nocompatible") -- ignored in neovim
-- vim.cmd("set t_Co=256") -- Force 256 colors on the terminal

-- needs to be reworked / old vimrc
vim.cmd([[
set shortmess+=c
let g:completion_matching_strategy_list=['exact', 'substring', 'fuzzy']
let g:completion_enable_auto_popup = 1
let g:lsp_diagnostics_echo_cursor = 1
]])
