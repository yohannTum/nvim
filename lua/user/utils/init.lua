-- todo : Telescope modules => reload

local telescope_status, _ = pcall(require,"telescope")
if not telescope_status then return end

local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local utils = require("telescope.utils")

local conf = require("telescope.config").values
local action_state = require "telescope.actions.state"

local ignored_packages = {
	["_G"] = "_G",
	["bit"] = "bit",
	["coroutine"] = "coroutine",
	["debug"] = "debug",
	["deps"] = "deps", -- all deps modules
	["dressing"] = "dressing",
	["dressing.patch"] = "dressing.patch",
	["ffi"] = "ffi",
	["io"] = "io",
	["jit"] = "jit", -- all jit modules
	["lib"] = "lib", -- all lib modules (lib.log)
	["luv"] = "luv",
	["math"] = "math",
	["mpack"] = "mpack",
	["os"] = "os",
	["package"] = "package",
	["string"] = "string",
	["table"] = "table",
	["vim"] = "vim", -- all vim modules
}

local function tableHasKey(table, key)
	local dot_pos = string.find(key, "%.")
	if dot_pos then
		key = string.sub(key, 1, dot_pos - 1)
	end
	return table[key] ~= nil
end

R = function(package_name)
	for name, _ in pairs(package.loaded) do
		if name:match(package_name) then
			package.loaded[name] = nil
			require(name)
		end
	end
end

RELOADER = function()
	local opts = {}
	local package_list = {}
	-- P(packer_plugins)

	-- filter out packages we don't want and track the longest package name
	local column_len = 0
	for module_name, _ in pairs(package.loaded) do
		if not tableHasKey(ignored_packages, module_name) or module_name:match('^user') then
			table.insert(package_list, module_name)
		end
		if #module_name > column_len then
			column_len = #module_name
		end
	end

	-- print("=========     package_list     =========")
	-- for _, module_name in pairs(package_list) do
	-- 	print(module_name)
	-- end

	-- print("=========     packer_list     =========")
	-- for name, index in pairs(packer_plugins) do
	-- 	print(name)
	-- 	P(index.path)
	-- end

	opts.column_len = vim.F.if_nil(opts.column_len, column_len)

	pickers
		.new(opts, {
			prompt_title = "Packages",
			finder = finders.new_table {
				results = package_list,
				entry_maker = opts.entry_maker or make_entry.gen_from_packages(opts),
			},
			-- previewer = previewers.vim_buffer.new(opts),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					if selection == nil then
						utils.__warn_no_selection "builtin.reloader"
						return
					end

					actions.close(prompt_bufnr)
					R(selection.value)
					utils.notify("builtin.reloader", {
						msg = string.format("[%s] - module reloaded", selection.value),
						level = "INFO",
					})
				end)

				return true
			end,
		})
		:find()
end

P = function(v)
	print(vim.inspect(v))
	return v
end
