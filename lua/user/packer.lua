local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer.. close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost packer.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)
	-- Basic stuff
	use { 'wbthomason/packer.nvim', opt = false } -- Have packer manage itself
	use { 'nvim-lua/popup.nvim' } -- An implementation of the Popup API from vim in Neovim
	use { 'nvim-lua/plenary.nvim' } -- Useful lua functions used in lots of plugins

	-- Colorschemes
	-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
	use { 'ellisonleao/gruvbox.nvim' } -- broken?? need airline support
	-- use { 'gruvbox-community/gruvbox' } -- broken??
	-- use { 'folke/lsp-colors.nvim' }
	use { 'sainnhe/gruvbox-material' }
	use {
		'luisiacc/gruvbox-baby',
		branch = 'main'
	}
	use { 'edeneast/nightfox.nvim' }
	use { 'tanvirtin/monokai.nvim' }
	use { 'bluz71/vim-moonfly-colors', as = 'moonfly' }
	use { 'rose-pine/neovim' }
	use { 'christianchiarulli/nvcode-color-schemes.vim' }
	use { 'ofirgall/ofirkai.nvim' }
	-- need to test them
	use { 'glepnir/zephyr-nvim' }
	use { 'olimorris/onedarkpro.nvim' }
	use { 'folke/tokyonight.nvim' }
	use { 'navarasu/onedark.nvim' }
	use { 'shaunsingh/nord.nvim' }
	use { 'rafamadriz/neon' }
	use { 'briones-gabriel/darcula-solid.nvim' }
	use { 'Mofiqul/dracula.nvim' }
	use { 'adisen99/codeschool.nvim' }
	use { 'kaiuri/nvim-juliana' }
	use { 'nekonako/xresources-nvim' }
	use { 'catppuccin/nvim' }
	-- use { 'artanikin/vim-synthwave84' }
	-- use { 'NLKNguyen/papercolor-theme' }
	-- use { 'sainnhe/sonokai' }
	-- use { 'rafi/awesome-vim-colorschemes' } -- doesn't seem to support treesitter
	-- use { 'rktjmp/lush.nvim' }

	-- MEH colorschemes
	use { 'marko-cerovac/material.nvim' }

	-- Others
	-- use { 'vim-airline/vim-airline' }
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use { 'andweeb/presence.nvim' }
	use { 'junegunn/fzf' }
	use { 'lervag/vimtex' }
	use { 'mbbill/undotree' }
	-- use { 'tpope/vim-surround' } -- TODO: keymap/options? -- not using it a lot
	-- use { 'mattn/emmet-vim' } -- TODO: keymap/options?
	use { 'jremmen/vim-ripgrep' } -- TODO: keymap/options?

	-- use {
	--     'chipsenkbeil/distant.nvim',
	--     config = function()
	--         require('distant').setup {
	--             -- Applies Chip's personal settings to every machine you connect to
	--             -- 1. Ensures that distant servers terminate with no connections
	--             -- 2. Provides navigation bindings for remote directories
	--             -- 3. Provides keybinding to jump into a remote file's parent directory
	--             ['*'] = require('distant.settings').chip_default()
	--         }
	--     end
	-- }

	-- Git
	use { 'tpope/vim-fugitive' } -- TODO: keymap
	-- use { 'jesseduffield/lazygit' } -- TODO: using it??
	use { 'TimUntersberger/neogit' }
	use { 'lewis6991/gitsigns.nvim' }
	use { 'sindrets/diffview.nvim' }

	-- cmp plugins
	use { 'hrsh7th/nvim-cmp' } -- The completion plugin
	use { 'hrsh7th/cmp-buffer' } -- buffer completions
	use { 'hrsh7th/cmp-cmdline' } -- cmdline completions
	use { 'hrsh7th/cmp-nvim-lsp' } -- Lsp completion support
	use { 'hrsh7th/cmp-nvim-lsp-signature-help' } -- Lsp signature
	use { 'hrsh7th/cmp-nvim-lua' } -- Lsp completion support for lua
	use { 'hrsh7th/cmp-path' } -- path completions
	use { 'saadparwaiz1/cmp_luasnip' } -- snippet completions
	use { 'ray-x/lsp_signature.nvim' }

	-- snippets
	use { 'L3MON4D3/LuaSnip' } --snippet engine
	use { 'rafamadriz/friendly-snippets' } -- a bunch of snippets to use

	-- Lsp
	use { 'neovim/nvim-lspconfig' }
	use { 'williamboman/mason.nvim' } -- simple to use language server installer
	use { 'williamboman/mason-lspconfig.nvim' } -- simple to use language server installer
	use { 'WhoIsSethDaniel/mason-tool-installer.nvim' } -- ensure language server, linter and more...
	use { 'jay-babu/mason-null-ls.nvim' }

	-- Whichkey
	use {
		"folke/which-key.nvim",
		--[[ config = function ()
			require("user.plugins.whichkey").setup()
		end]]
	}
	-- Java
	use { 'mfussenegger/nvim-jdtls' }

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		opt = false,
		run = ':TSUpdate',
		-- confip = print('treesitter is loaded'),
	}
	use { 'nvim-treesitter/playground' }

	-- Prettier
	use { 'jose-elias-alvarez/null-ls.nvim' }
	-- use { 'MunifTanjim/prettier.nvim' }
	-- use { 'mhartington/formatter.nvim' }

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or                            , branch = '0.1.x',
		requires = {
			{ 'nvim-lua/plenary.nvim' },

			{ 'nvim-telescope/telescope-symbols.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
		}
	}

	use { "stevearc/dressing.nvim" }
	use { "ziontee113/icon-picker.nvim", config = function()
		require("icon-picker").setup({ disable_legacy_commands = true })
	end }

	-- Harpoon
	use { 'ThePrimeagen/harpoon',
		requires = { { 'nvim-lua/plenary.nvim' } } }

	-- Rofi settup
	use { 'Fymyte/rasi.vim', ft = 'rasi' }

	-- nvim tree
	use {
		'kyazdani42/nvim-tree.lua',
		commit = '55028e30d7f897711c6469ea93a316f0f12223d4'
		-- tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
	use { 'kyazdani42/nvim-web-devicons' }

	-- dotnet devlopement
	-- use { 'OmniSharp/omnisharp-vim' }
	use { 'Hoffs/omnisharp-extended-lsp.nvim' }

	-- vue developement
	use { 'posva/vim-vue' }

	-- markdown
	use { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end }

	-- Lua
	use { 'folke/neodev.nvim' }

	-- Docker :/
	use { '/home/yohann/github/nvim-dev-container' }
	use { '/home/yohann/plugins/devcontainercli' }
	-- use { 'jamestthompson3/nvim-remote-containers' }
	use { 'miversen33/netman.nvim' }
	-- use { 'esensar/nvim-dev-container' }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
