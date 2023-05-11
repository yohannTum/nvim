-- :h nvim-treesitter
local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then return end

local split = require("user.utils.split").split

---@return string[]
local function get_treesitter_env_parsers()
	---@type string|nil
	local treesitter_envs = vim.env.NEOVIM_TREESITTER

	if not (treesitter_envs ~= nil) then return {} end

	if treesitter_envs == "" then return {} end

	return split(treesitter_envs, ':')
end

---@return string|nil
local function get_treesitter_env_all()
	if vim.env.NEOVIM_TREESITTER_ALL ~= nil then
		return "all"
	end
	return nil
end

---@type string[]
local ensure_parser_installed = {}
local ts_env_parsers = get_treesitter_env_parsers()
for _, ts_env_parser in ipairs(ts_env_parsers) do
	table.insert(ensure_parser_installed, ts_env_parser)
end
local ensure_all_installed = get_treesitter_env_all()

configs.setup {
	ensure_installed = ensure_all_installed or ensure_parser_installed, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
