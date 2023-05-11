local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then return end
lualine.setup {
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
			function()
				return require("user.utils.dev-container-statusbar").status()
			end,
		},
		lualine_x = { 'diagnostics', 'encoding', 'fileformat' },
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
