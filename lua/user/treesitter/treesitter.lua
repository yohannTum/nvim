-- :h nvim-treesitter
local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then return end

configs.setup {
	ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true,
		-- disable = { "php", "css" },  -- list of language that will be disabled
		disable = {
			-- "vim"
			-- "html",
			-- "css",
			-- "javascript",
			-- "typescript",
			-- "tsx"
			-- "blade",
			-- "vue"
		},
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<space>zt" -- TODO: find better keymaps
		},
	},
	indent = {
		enable = true,
		disable = { "yaml" }
	},
	playground = {
		enable = true
	},
	query_linter = {
		enable = true
	}
}
