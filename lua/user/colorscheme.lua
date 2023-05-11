local colorscheme = "gruvbox-material"
-- ofirkai (sublime text 3)
-- rose-pine
-- carbonfox
-- gruvbox-material
-- gruvbox-baby
-- monokai_pro
-- moonfly
-- gruvbox

if colorscheme == "gruvbox-material" then
	--[[ background colors :
		#1d2021
		#282828
		#32302f
		#32302f
    ]]
	vim.cmd("let g:gruvbox_material_background = 'medium'") -- soft, medium, hard
	vim.cmd("let g:gruvbox_material_foreground = 'original'") -- material, mix, original
	-- vim.cmd("let g:airline_theme = 'gruvbox_material'")
	vim.cmd("let g:gruvbox_material_ui_contrast = 'hard'")
	vim.cmd("let g:gruvbox_material_colors_override = {'bg0': ['#272822', '234']}") -- monokai bg
	-- vim.cmd("let g:gruvbox_material_colors_override = {'bg0': ['#1d2021', '234']}") -- blueish dark bg
	-- vim.cmd("let g:gruvbox_material_colors_override = {'bg0': ['#111213', '234']}") -- ultra dark bg
	vim.cmd("let g:gruvbox_material_statusline_style = 'original'")
	vim.cmd("let g:gruvbox_material_diagnostic_virtual_text = 'colored'") -- soft, medium, hard

	vim.cmd("colorscheme " .. colorscheme)
elseif colorscheme == "ofirkai" then
	local ok, ofirkai = pcall(require, "ofirkai")
	if not ok then return end
	-- fix : comment the instruction lua require("ofirkai").setup({}) located at :
	-- ~/.local/share/nvim/site/pack/packer/start/ofirkai.nvim/colors/ofirkai.vim
	-- TODO: (for devcli purpose)
	-- TODO: lua cmd bash command to comment/delete the line at the file above
	-- example : echo '' > ~/.....etc..../ofirkai.vim
	-- vim.fn.stdpath("data") .. "/site/pack/packer/start/ofirkai.nvim/colors/ofirkai.vim"
	local ofirkai_vim_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/ofirkai.nvim/colors/ofirkai.vim"
	os.execute("echo '' > ".. ofirkai_vim_path)
	ofirkai.setup {
		scheme = {
			black = '#1d2021',
			telescope_bg = '#1d2021',
			ui_bg = '#1d2021',
			secondary_background = '#1d2021',
		-- 	dark_pink = '#d3869b',
		-- 	red = '#cc241d',
		-- 	light_red = '#fb4934',
		-- 	purple = '#b16286',
		-- 	white = '#ebdbb2',
		-- 	yellow = '#fabd2f',
		-- 	orange = '#fe8019',
		-- 	aqua = '#83a598',
		-- 	green = '#b8bb26',
		},
		custom_hlgroups = {
			LineNr			= {fg = '#7c6f64'},
			NvimTreeLineNr	= {fg = '#7c6f64', bg = '#282923'},
			NvimTreeNormal	= {bg = '#282923'},
			NvimTreeWindowPicker	= {fg = '#fabd2f'},
			NvimTreeRootFolder		= {fg = '#7c6f64'},
			-- WarningMsg				= {fg = '#e95678', bold = true},
			-- DiagnosticSignWarn		= {fg = '#e95678'},
			DiagnosticVirtualTextWarn = {fg = '#fd971f'},
		}
	}
	-- Maybe it is working if this code is being run in after/plugin/colors.lua
	-- example (https://github.com/Nick-Mazuk/neovim-config/blob/c4be518346f916126b28399053402a82eaf6602d/after/plugin/colors.lua) :
	--[[
	local monokai = require('monokai')
	local palette = monokai.pro
	palette.base1 = "#1b1b1b"
	monokai.setup {
		palette = palette,
		custom_hlgroups = {
			Normal = {
				bg = palette.base1,
			}
		}
	}]]
elseif colorscheme == "gruvbox-baby" then
	vim.g.gruvbox_baby_background_color = 'dark'
	vim.g.gruvbox_baby_use_original_palette = true
	vim.cmd("colorscheme " .. colorscheme)
elseif colorscheme == "gruvbox" then
	vim.cmd("colorscheme " .. colorscheme)
elseif colorscheme == "nvcode_gruvbox" then
	vim.cmd("colorscheme " .. colorscheme)
elseif colorscheme == "monokai_pro" then
	-- TODO: setup bg
	vim.cmd("colorscheme " .. colorscheme)
elseif colorscheme == "carbonfox" then
	vim.cmd("colorscheme " .. colorscheme)
elseif colorscheme == "rose-pine" then
	require('rose-pine').setup({
		--- @usage 'main' | 'moon'
		dark_variant = 'main',
		bold_vert_split = false,
		dim_nc_background = false,
		disable_background = false,
		disable_float_background = false,
		disable_italics = false,
	
		--- @usage string hex value or named color from rosepinetheme.com/palette
		groups = {
			background = '#272822',
			panel = 'surface',
			border = 'highlight_med',
			comment = 'muted',
			link = 'iris',
			punctuation = 'subtle',
	
			error = 'love',
			hint = 'iris',
			info = 'foam',
			warn = 'gold',
	
			headings = {
				h1 = 'iris',
				h2 = 'foam',
				h3 = 'rose',
				h4 = 'gold',
				h5 = 'pine',
				h6 = 'foam',
			}
			-- or set all headings at once
			-- headings = 'subtle'
		},
	
		-- Change specific vim highlight groups
		highlight_groups = {
			ColorColumn = { bg = 'rose' }
		}
	})
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
