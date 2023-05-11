local status, devcontainer = pcall(require, "devcontainer")
if not status then
	-- print("devcontainer module not present")
	return
end

-- vim.api.nvim_open_win() -- needs a bufer, see nvim_create_buf()
-- 2nd option
-- |nvim_win_set_config()| reconfigures a normal window into a float

-- to close :
-- nvim_win_close()

-- local buf = vim.api.nvim_create_buf(false, true)
-- local opts = {
-- 	relative='cursor',
-- 	width=10,
-- 	height=2,
-- 	col=0,
-- 	row=1,
-- 	anchor='NW',
-- 	style='minimal'
-- }
-- local window = vim.api.nvim_open_win(buf, 0, opts)
-- let buf = nvim_create_buf(v:false, v:true)
-- call nvim_buf_set_lines(buf, 0, -1, v:true, ["test", "text"])
-- let opts = {'relative': 'cursor', 'width': 10, 'height': 2, 'col': 0,
--     \ 'row': 1, 'anchor': 'NW', 'style': 'minimal'}
-- let win = nvim_open_win(buf, 0, opts)
-- " optional: change highlight, otherwise Pmenu is used
-- call nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')

devcontainer.setup {
	config_search_start = function()
		print("Searching for devcontainer.json ...")
		return vim.loop.cwd()
	end,

	nvim_dockerfile_template = function(base_image)
		-- local version_string = "release-0.7"
		print("installing nvim release-0.7 based on image : " .. base_image)
		local lines = {
			"FROM " .. base_image,
			-- neovim dependencies
			"RUN apt-get update && apt-get -y install " .. table.concat({
				"ninja-build",
				"gettext",
				"libtool",
				"libtool-bin",
				"autoconf",
				"automake",
				"cmake",
				"g++",
				"pkg-config",
				"unzip",
				"curl",
				"doxygen",
			}, " "),
			-- external tools used by my config
			"RUN apt-get -y install " .. table.concat({
				"fzf",
				"ripgrep",
				"tree",
				"git",
				"xclip",
				"python3",
				"python3-pip",
				"nodejs",
				"npm",
				"tzdata",
				"zip",
			}, " "),
			"RUN mkdir -p /root/TMP",
			"RUN cd /root/TMP && git clone https://github.com/neovim/neovim",
			"RUN pip3 install pynvim",
			"RUN npm i -g neovim",
			"RUN cd /root/TMP/neovim && git checkout release-0.7 && make CMAKE_BUILD_TYPE=Release -j4 && make install",
			-- "RUN cd /root/TMP/neovim && (git checkout " .. version_string .. " || true) && make -j4 && make install",
			-- "RUN rm -rf /root/TMP",
		}
		return table.concat(lines, "\n")
	end,
	-- Can be set to false to prevent generating default commands
	-- Default commands are listed below
	generate_commands = true,
	-- By default no autocommands are generated
	-- This option can be used to configure automatic starting and cleaning of containers
	autocommands = {
		-- can be set to true to automatically start containers when devcontainer.json is available
		init = false,
		-- can be set to true to automatically remove any started containers and any built images when exiting vim
		clean = false,
		-- can be set to true to automatically restart containers when devcontainer.json file is updated
		update = false,
	},
	-- can be changed to increase or decrease logging from library
	log_level = "debug",
	-- can be set to true to disable recursive search
	-- in that case only .devcontainer.json and .devcontainer/devcontainer.json files will be checked relative
	-- to the directory provided by config_search_start
	disable_recursive_config_search = false,
	--
	-- This takes a string (usually either "podman" or "docker") representing container runtime
	-- That is the command that will be invoked for container operations
	-- If it is nil, plugin will use whatever is available (trying "podman" first)
	container_runtime = nil,
	-- This takes a string (usually either "podman-compose" or "docker-compose") representing compose command
	-- That is the command that will be invoked for compose operations
	-- If it is nil, plugin will use whatever is available (trying "podman-compose" first)
	compose_command = nil,
}
