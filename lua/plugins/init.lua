return {
	'nvim-lua/popup.nvim', -- An implementation of the Popup API from vim in Neovim
	'nvim-lua/plenary.nvim', -- Useful lua functions used in lots of plugins
	'lervag/vimtex',
	'jremmen/vim-ripgrep', -- TODO: keymap/options?

	-- Git

	-- Lsp
	--- 'jay-babu/mason-null-ls.nvim',

	-- Prettier
	-- 'jose-elias-alvarez/null-ls.nvim',

	"stevearc/dressing.nvim",
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({ disable_legacy_commands = true })
		end,
		commit = "0f3b2648f6f8e788bc8dfe37bc9bb18b565cfc3c"
	},

	-- Rofi settup
	{
		'Fymyte/rasi.vim',
		ft = 'rasi',
		commit = "a3c5eaf37f2f778f4d62dad2f1e3dbb4596ac6eb"
	},


	-- dotnet devlopement
	-- use { 'OmniSharp/omnisharp-vim' }
	--- 'Hoffs/omnisharp-extended-lsp.nvim',

	-- vue developement
	'posva/vim-vue',

	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end
	},

	-- Lua

	-- Docker :/
	-- 'jamestthompson3/nvim-remote-containers',
	--- 'miversen33/netman.nvim',
	-- 'esensar/nvim-dev-container',

	-- C++
	--- 'cdelledonne/vim-cmake',
}
