return {
	'folke/which-key.nvim',
	event = "VeryLazy",
	lazy = false,
	config = function ()
		local whichkey = require("which-key")
		whichkey.register({
			-- GROUP NAMES
			["<Leader>"] = { name = "Extend" },
			["/"] = { name = "Search" },
		}, { prefix = "<Leader>" })
	end,
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			presets = {
				operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = false, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		operators = { gc = "Comments" },
		key_labels = {
			["<Leader>"] = "␣",
			["<leader>"] = "LEADER",
		},
		icons = {
			breadcrumb = "", -- symbol used in the command line area that shows your active key combo
			separator = ":", -- symbol used between a key and it's label
			group = " ", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = '<c-d>', -- binding to scroll down inside the popup
			scroll_up = '<c-u>', -- binding to scroll up inside the popup
		},
		window = {
			border = "none", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			winblend = 0
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		triggers = "auto", -- automatically setup triggers
		triggers_blacklist = {
			i = { "j", "k" },
			v = { "j", "k" },
		},
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	},
}
