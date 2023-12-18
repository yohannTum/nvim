
local function optsdesc(desc)
	return { desc = desc, noremap = true, silent = true }
end

return {
	'sindrets/diffview.nvim',
	keys = {
		{ "<leader>gm", ":DiffviewOpen<CR>", desc = "git merge", noremap = true, silent = true }
	},
	config = function ()
		local whichkey_status, whichkey = pcall(require, "which-key")
		if not whichkey_status then return end

		local diffview = require("diffview")
		diffview.setup({
			diff_binaries = false, -- Show diffs for binaries
			enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
			git_cmd = { "git" }, -- The git executable followed by default args.
			use_icons = true, -- Requires nvim-web-devicons
			watch_index = true, -- Update views and index buffers when the git index changes.
			icons = { -- Only applies when use_icons is true.
				folder_closed = "",
				folder_open = "",
			},
			signs = {
				fold_closed = "",
				fold_open = "",
				done = "✓",
			},
			view = {
				-- Configure the layout and behavior of different types of views.
				-- Available layouts:
				--  'diff1_plain'
				--    |'diff2_horizontal'
				--    |'diff2_vertical'
				--    |'diff3_horizontal'
				--    |'diff3_vertical'
				--    |'diff3_mixed'
				--    |'diff4_mixed'
				-- For more info, see ':h diffview-config-view.x.layout'.
				default = {
					-- Config for changed files, and staged files in diff views.
					layout = "diff2_horizontal",
				},
				merge_tool = {
					-- Config for conflicted files in diff views during a merge or rebase.
					layout = "diff3_horizontal",
					disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
				},
				file_history = {
					-- Config for changed files in file history views.
					layout = "diff2_horizontal",
				},
			},
			file_panel = {
				listing_style = "tree", -- One of 'list' or 'tree'
				tree_options = { -- Only applies when listing_style is 'tree'
					flatten_dirs = true, -- Flatten dirs that only contain one single dir
					folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
				},
				win_config = { -- See ':h diffview-config-win_config'
					position = "left",
					width = 35,
					win_opts = {}
				},
			},
			file_history_panel = {
				log_options = { -- See ':h diffview-config-log_options'
					git = {
						single_file = {
							diff_merges = "combined",
						},
						multi_file = {
							diff_merges = "first-parent",
						},
					},
				},
				win_config = { -- See ':h diffview-config-win_config'
					position = "bottom",
					height = 16,
					win_opts = {}
				},
			},
			commit_log_panel = {
				win_config = { -- See ':h diffview-config-win_config'
					win_opts = {},
				}
			},
			default_args = { -- Default args prepended to the arg-list for the listed commands
				DiffviewOpen = {},
				DiffviewFileHistory = {},
			},
			hooks = { -- See ':h diffview-config-hooks'
				diff_buf_read = function(bufnr)
					if whichkey_status then
						whichkey.register({ ["<Leader>gc"] = { name = "Choose Conflict" } }, { buffer = bufnr })
					end
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gu", ":lua require('diffview.actions').focus_files()<CR>", optsdesc("Focus File Panel"))
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gb", ":lua require('diffview.actions').toggle_files()<CR>", optsdesc("Toggle File Panel"))
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gn", ":lua require('diffview.actions').next_conflict()<CR>", optsdesc("Next conflict")) -- conflict / hunk?
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gp", ":lua require('diffview.actions').prev_conflict()<CR>", optsdesc("Previous conflict"))

					-- Choose conflict
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gco", ':lua require("diffview.actions").conflict_choose("ours")()<CR>', optsdesc("OURS"))
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gct", ':lua require("diffview.actions").conflict_choose("theirs")()<CR>', optsdesc("THEIRS"))
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gcb", ':lua require("diffview.actions").conflict_choose("base")()<CR>', optsdesc("BASE"))
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gca", ':lua require("diffview.actions").conflict_choose("all")()<CR>', optsdesc("ALL (choose all the versions)"))
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gcx", ':lua require("diffview.actions").conflict_choose("none")()<CR>', optsdesc("NONE (delete conflict region)"))

					-- diffget (diff3 view)
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gch", ':lua require("diffview.actions").diffget("ours")()<CR>', optsdesc("OURS (left)"))
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gcl", ':lua require("diffview.actions").diffget("theirs")()<CR>', optsdesc("THEIRS (right)"))
				end,
			},
			keymaps = {
				disable_defaults = true, -- Disable the default keymaps
				view = {
					-- The `view` bindings are active in the diff buffers, only when the current
					-- tabpage is a Diffview.
					["<C-l>"]       = diffview.actions.select_next_entry, -- Open the diff for the next file
					["<C-h>"]       = diffview.actions.select_prev_entry, -- Open the diff for the previous file
					["gf"]          = diffview.actions.goto_file, -- Open the file in a new split in the previous tabpage
					-- ["<C-w><C-f>"]	= diffview.actions.goto_file_split,           -- Open the file in a new split
					-- ["<C-w>gf"]	= diffview.actions.goto_file_tab,             -- Open the file in a new tabpage
					-- ["g<C-x>"]		= diffview.actions.cycle_layout,              -- Cycle through available layouts.
				},
				diff1 = { --[[ Mappings in single window diff layouts ]] },
				diff2 = { --[[ Mappings in 2-way diff layouts ]] },
				diff3 = {
					-- Mappings in 3-way diff layouts
					{ { "n", "x" }, "<leader>gch", diffview.actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
					{ { "n", "x" }, "<leader>gcl", diffview.actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
				},
				diff4 = {
					-- Mappings in 4-way diff layouts
					{ { "n", "x" }, "1do", diffview.actions.diffget("base") }, -- Obtain the diff hunk from the BASE version of the file
					{ { "n", "x" }, "2do", diffview.actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
					{ { "n", "x" }, "3do", diffview.actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
				},
				file_panel = {
					["j"]             = diffview.actions.next_entry, -- Bring the cursor to the next file entry
					["k"]             = diffview.actions.prev_entry, -- Bring the cursor to the previous file entry.
					["<cr>"]          = diffview.actions.select_entry, -- Open the diff for the selected entry.
					["o"]             = diffview.actions.select_entry,
					["l"]             = diffview.actions.select_entry,
					["<2-LeftMouse>"] = diffview.actions.select_entry,
					["-"]             = diffview.actions.toggle_stage_entry, -- Stage / unstage the selected entry.
					["S"]             = diffview.actions.stage_all, -- Stage all entries.
					["U"]             = diffview.actions.unstage_all, -- Unstage all entries.
					["X"]             = diffview.actions.restore_entry, -- Restore entry to the state on the left side.
					["L"]             = diffview.actions.open_commit_log, -- Open the commit log panel.
					["<c-b>"]         = diffview.actions.scroll_view(-0.25), -- Scroll the view up
					["<c-f>"]         = diffview.actions.scroll_view(0.25), -- Scroll the view down
					["<tab>"]         = diffview.actions.select_next_entry,
					["<s-tab>"]       = diffview.actions.select_prev_entry,
					["gf"]            = diffview.actions.goto_file,
					-- ["<C-w><C-f>"]    = diffview.actions.goto_file_split,
					-- ["<C-w>gf"]       = diffview.actions.goto_file_tab,
					["i"]             = diffview.actions.listing_style, -- Toggle between 'list' and 'tree' views
					["f"]             = diffview.actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
					["R"]             = diffview.actions.refresh_files, -- Update stats and entries in the file list.
					-- ["l"]				= diffview.actions.focus_files,
					["<leader>gu"]    = diffview.actions.toggle_files,
					-- ["g<C-x>"]	    = diffview.actions.cycle_layout,
					["<leader>gp"]    = diffview.actions.prev_conflict,
					["<leader>gn"]    = diffview.actions.next_conflict,
				},
				file_history_panel = {
					["g!"]            = diffview.actions.options, -- Open the option panel
					["<C-A-d>"]       = diffview.actions.open_in_diffview, -- Open the entry under the cursor in a diffview
					["y"]             = diffview.actions.copy_hash, -- Copy the commit hash of the entry under the cursor
					["L"]             = diffview.actions.open_commit_log,
					["zR"]            = diffview.actions.open_all_folds,
					["zM"]            = diffview.actions.close_all_folds,
					["j"]             = diffview.actions.next_entry,
					["<down>"]        = diffview.actions.next_entry,
					["k"]             = diffview.actions.prev_entry,
					["<up>"]          = diffview.actions.prev_entry,
					["<cr>"]          = diffview.actions.select_entry,
					["o"]             = diffview.actions.select_entry,
					["<2-LeftMouse>"] = diffview.actions.select_entry,
					["<c-b>"]         = diffview.actions.scroll_view(-0.25),
					["<c-f>"]         = diffview.actions.scroll_view(0.25),
					["<tab>"]         = diffview.actions.select_next_entry,
					["<s-tab>"]       = diffview.actions.select_prev_entry,
					["gf"]            = diffview.actions.goto_file,
					["<C-w><C-f>"]    = diffview.actions.goto_file_split,
					["<C-w>gf"]       = diffview.actions.goto_file_tab,
					["<leader>e"]     = diffview.actions.focus_files,
					["<leader>b"]     = diffview.actions.toggle_files,
					["g<C-x>"]        = diffview.actions.cycle_layout,
				},
				option_panel = {
					["<tab>"] = diffview.actions.select_entry,
					["q"]     = diffview.actions.close,
				},
			},
		})
	end
}
