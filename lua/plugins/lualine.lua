-- LSP clients attached to buffer
local clients_lsp = function ()
	local bufnr = vim.api.nvim_get_current_buf()

	local clients = vim.lsp.get_active_clients({bufnr = bufnr})
	if next(clients) == nil then
		return ''
	end

	local c = {}
	for _, client in pairs(clients) do
		table.insert(c, client.name)
	end
	return '\u{f085}  ' .. table.concat(c, ' │ ')
end

local lsp_progress = function()
	local lsp = vim.lsp.util.get_progress_messages()[1]
	if lsp then
		local name = lsp.name or ""
		local msg = lsp.message or ""
		local percentage = lsp.percentage or 0
		local title = lsp.title or ""
		return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
	end

	return ""
end

return {
	'nvim-lualine/lualine.nvim',
	dependencies = {
		'kyazdani42/nvim-web-devicons',
	},
	config = {
		options = {
			theme = 'jellybeans',
			-- theme = require("ofirkai.statuslines.lualine").theme,
			section_separators = { left = '', right = '' },
			component_separators = { left = '┃', right = '│' },
			globalstatus = true,
			refresh = { -- calling refresh function : require("lualine").refresh()
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			}
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff' },
			lualine_c = {
				'filename',
				-- everything that is loading/processing
				function ()
					return require("user.utils.dev-container-statusbar").status()
				end,
			},
			lualine_x = {
				{
					'diagnostics',
					symbols = { error = ' ', warn = ' ', info = ' ', hint = ' '},
					-- always_visible = true,
				}, 'encoding', 'fileformat', clients_lsp },
			lualine_y = { 'filetype' },
			lualine_z = { 'location', 'progress' },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {}
		},
	}
}
