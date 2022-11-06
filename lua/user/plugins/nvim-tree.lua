-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local opts = {}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

-- :h nvim-tree-api
-- require("nvim-tree.api").tree.toggle(true)
function NvimTreeToggle()
	local nt = require("nvim-tree.api")
	-- vim.api.nvim_get_current_buf(0)
	-- vim.api.nvim_buf_get_name(0)
	local buf_name = vim.fn.expand('%')
	if not (string.match(buf_name, "NvimTree_.") == nil) then -- if we are in the buffer NvimTree
		nt.tree.close()
	else
		nt.tree.focus() -- go to nvim-tree
	end
end

function NvimTreeFocusFile()
	local nt = require("nvim-tree.api")
	local buf_name = vim.fn.expand('%')
	if not (string.match(buf_name, "NvimTree_.") == nil) then -- if we are in the buffer NvimTree
		nt.tree.close()
	else
		local path = vim.api.nvim_buf_get_name(0)
		nt.tree.focus() -- go to nvim-tree
		nt.tree.find_file(path)
	end
end

-- vim.api.nvim_set_keymap('n', '<Leader>u', '<cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })

nvim_tree.setup {
	-- auto_close = true,
	-- disable_netrw = true,
	-- disable_window_picker = 0,
	diagnostics = {
		enable = true,
		--   error
		--   info
		--   question
		--   warning
		--   lightbulb
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	-- filters = {
	--   dotfiles = false,
	--   custom = {},
	-- },
	-- git_hl = 1,
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	-- hijack_cursor = false,
	-- hijack_netrw = true,
	hijack_directories = {
		enable = false,
	},
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	-- open_on_setup = false,
	-- open_on_tab = false,
	-- quit_on_open = 0,
	-- root_folder_modifier = ":t",
	renderer = {
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				git = {
					-- unstaged = "~",
					staged = ".",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌",
				},
			}
		}
	},
	-- show_icons = {
	--   git = 1,
	--   folders = 1,
	--   files = 1,
	--   folder_arrows = 1,
	--   tree_width = 30,
	-- },
	-- system_open = {
	--   cmd = nil,
	--   args = {},
	-- },
	-- trash = {
	--   cmd = "trash",
	--   require_confirm = true,
	-- },
	update_cwd = true,
	update_focused_file = {
		-- enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	-- update_to_buf_dir = {
	--   enable = true,
	--   auto_open = true,
	-- },
	-- update_to_buf_dir = {
	--   enable = false,
	-- },
	view = {
		-- width = 30,
		-- height = 30,
		-- auto_resize = true,
		hide_root_folder = false,
		number = false,
		relativenumber = true,
		side = "left",
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
				{ key = "h", cb = tree_cb "close_node" },
				{ key = "v", cb = tree_cb "vsplit" },
			},
		},
	},
}
