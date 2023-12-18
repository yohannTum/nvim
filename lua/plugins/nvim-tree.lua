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

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach#example
local function nvim_tree_keymaps(bufnr)
	local api = require('nvim-tree.api')

	local function opts(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	vim.keymap.set('n', '<CR>',		api.node.open.edit,					opts('Open'))
	vim.keymap.set('n', 'l',		api.node.open.edit,					opts('Open'))
	vim.keymap.set('n', 'o',		api.node.open.edit,					opts('Open'))
	vim.keymap.set('n', 'h',		api.node.navigate.parent_close,		opts('Close Directory'))
	vim.keymap.set('n', 'v',		api.node.open.vertical,				opts('Open: Vertical Split'))
end

-- :h nvim-tree-highlight
local function nvim_tree_theme()
	--[[
	red		#fb4934 #cc241d #9d0006
	orange	#fe8019 #d65d0e #af3a03
	blue	#83a598 #458588 #076678
	--]]

	-- Folder
	-- vim.cmd[[highlight NvimTreeFolderName guifg=#458588]]
	-- vim.cmd[[highlight NvimTreeEmptyFolderName guifg=#458588]]
	-- vim.cmd[[highlight NvimTreeOpenedFolderName guifg=#83a598 gui=bold]]
	-- vim.cmd[[highlight NvimTreeFolderIcon guifg=#83a598]]

	-- General cursor line
	vim.cmd[[highlight CursorLineNr guifg=#b16286 guibg=#32302f]]
	vim.cmd[[highlight CursorLine guibg=#272822]]

	-- Folder v2
	vim.cmd[[highlight NvimTreeFolderName guifg=#ebdbb2]]
	vim.cmd[[highlight NvimTreeEmptyFolderName guifg=#ebdbb2]]
	vim.cmd[[highlight NvimTreeOpenedFolderName guifg=#ebdbb2 gui=bold]]
	vim.cmd[[highlight NvimTreeFolderIcon guifg=#83a598]]

	-- General
	vim.cmd[[highlight NvimTreeCursorLine guibg=#32302f]]
	vim.cmd[[highlight NvimTreeCursorLineNr guifg=#b16286 guibg=#32302f]]
	vim.cmd[[highlight NvimTreeNormal guifg=#fff6ea guibg=#272822]]
	vim.cmd[[highlight NvimTreeEndOfBuffer guibg=#272822]]
	vim.cmd[[highlight NvimTreeWindowPicker guifg=#fabd2f]]
	vim.cmd[[highlight NvimTreeRootFolder guifg=#7c6f64]]

	-- Git v1
	-- vim.cmd[[highlight NvimTreeGitStaged guifg=#fabd2f gui=bold]]
	-- vim.cmd[[highlight NvimTreeGitNew guifg=#fd971f gui=bold]]
	-- vim.cmd[[highlight NvimTreeGitDirty guifg=#e6db74 gui=bold]]
	-- vim.cmd[[highlight NvimTreeGitRenamed guifg=#e95678 gui=bold]]

	-- Git v2
	vim.cmd[[highlight NvimTreeGitStaged guifg=#b8bb26 gui=bold]] -- light green
	vim.cmd[[highlight NvimTreeGitNew guifg=#689d6a gui=bold]] -- dark aqua
	vim.cmd[[highlight NvimTreeGitDirty guifg=#e6db74 gui=bold]] -- yellow
	vim.cmd[[highlight NvimTreeGitRenamed guifg=#e95678 gui=bold]]

end

return {
	'kyazdani42/nvim-tree.lua',
	commit = '55028e30d7f897711c6469ea93a316f0f12223d4',
	-- tag = 'nightly' -- optional, updated every week. (see issue #1193)
	lazy = false,
	dependencies = { 'kyazdani42/nvim-web-devicons' },
	keys = {
		{"<Leader>u", ":lua NvimTreeToggle()<CR>", desc = "NvimTree Toggle", noremap = true , silent = true},
		{"<Leader>U", ":lua NvimTreeFocusFile()<CR>", desc = "NvimTree Focus Current File", noremap = true, silent = true},
	},
	config = {
		filesystem_watchers = {
			enable = false
		},
		diagnostics = {
			enable = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		git = {
			enable = true,
			ignore = true,
			timeout = 500,
		},
		hijack_directories = {
			enable = false,
		},
		ignore_ft_on_setup = {
			"startify",
			"dashboard",
			"alpha",
		},
		renderer = {
			highlight_git = true,
			icons = {
				glyphs = {
					default = "",
					symlink = "",
					git = {
						unstaged = "•",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						deleted = "",
						untracked = "🟉",
						ignored = "◌",
					},
				}
			}
		},
		update_cwd = true,
		update_focused_file = {
			update_cwd = true,
			ignore_list = {},
		},
		view = {
			hide_root_folder = false,
			number = false,
			relativenumber = true,
			side = "left",
		},
		on_attach = function (bufnr)
			nvim_tree_keymaps(bufnr)
			nvim_tree_theme()
		end
	}
}
