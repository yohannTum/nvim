return {
	'petertriho/nvim-scrollbar',
	opts = {
		-- show_in_active_only = true,
		excluded_filetypes = {
			'neo-tree',
			'NvimTree',
			'nvim-tree'
		},
		handle = {
			blend = 90,
			highlight = "Cursor",
		},
		marks = {
			Cursor = {
				text = " ",
				priority = 99,
			},
			Info = {
				text = { "-", "―" },
			},
			Error = {
				text = { "-", "―" },
			},
			Warn = {
				text = { "-", "―" },
			},
			Misc = {
				text = { "-", "―" },
			},
			Hint = {
				text = { "-", "―" },
			},
		},
	}
}
