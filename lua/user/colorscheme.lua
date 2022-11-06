local colorscheme = "gruvbox-material"
-- gruvbox
-- gruvbox-material

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
elseif colorscheme == "gruvbox" then
	vim.o.background = "dark"
	-- do stuff for gruvbox
	vim.g.gruvbox_contrast_dark = 'dark'
	vim.g.gruvbox_colors_bg1 = '#D5C4A1'
	vim.g.gruvbox_invert_selection = '0'
	vim.cmd([[
    if exists('+termguicolors')
	    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	end
	]])
	vim.cmd("colorscheme " .. colorscheme)
	-- vim.notify("Current colorscheme : " .. colorscheme)
	--[[ change background color? => colors.lua
    -  dark0_hard = hsl("#1d2021"),
	+  -- dark0_hard = hsl("#1d2021"),
	+  dark0_hard = hsl("#111213"),
	]]
elseif colorscheme == "gruvbox-material" then
	--[[ background colors :
		#1d2021
		#282828
		#32302f
		#32302f
    ]]
	vim.cmd("let g:gruvbox_material_background = 'medium'") -- soft, medium, hard
	vim.cmd("let g:gruvbox_material_foreground = 'original'") -- material, mix, original
	vim.cmd("let g:airline_theme = 'gruvbox_material'")
	vim.cmd("let g:gruvbox_material_ui_contrast = 'hard'")
	vim.cmd("let g:gruvbox_material_colors_override = {'bg0': ['#272822', '234']}") -- monokai bg
	-- vim.cmd("let g:gruvbox_material_colors_override = {'bg0': ['#1d2021', '234']}") -- blueish dark bg
	-- vim.cmd("let g:gruvbox_material_colors_override = {'bg0': ['#111213', '234']}") -- ultra dark bg
	vim.cmd("let g:gruvbox_material_statusline_style = 'original'")
	vim.cmd("colorscheme " .. colorscheme)
else
	vim.cmd("colorscheme default")
end


--[[ OTHER OPTIONS TO EXPLORE : (older vimrc)
" Plug 'rafi/awesome-vim-colorschemes'
Plug 'sainnhe/sonokai'
let g:sonokai_transparent_background = 1

" let g:sonokai_style = 'default'
let g:sonokai_style = 'shusia'
" let g:sonokai_style = 'espresso'
" let g:sonokai_style = 'shusia'


Plug 'artanikin/vim-synthwave84'
set background=dark

Plug 'NLKNguyen/papercolor-theme'
set background=dark


" Plug 'morhetz/gruvbox'
" Plug 'ellisonleao/gruvbox.nvim'
" Plug 'rktjmp/lush.nvim'
" dark
" let g:gruvbox_contrast_dark = 'hard' "only this one to toggle for now
let g:gruvbox_transparent_bg = 1
let g:gruvbox_colors_bg1 = '#111213'
" let g:gruvbox_colors_bg1 = '#D5C4A1'

" light
let g:gruvbox_contrast_light = 'hard'

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
end

let g:gruvbox_invert_selection='0'
set background=dark
]]
