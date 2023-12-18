local mason_installer_status, mason_installer = pcall(require, "mason-tool-installer")
if not mason_installer_status then
	return
end

local split = require("user.utils.split").split

local function get_mason_env_servers()
	local result = {}
	---@type string|nil
	local mason_servers_envs = vim.env.NEOVIM_MASON
	if not (mason_servers_envs ~= nil) then return {} end

	if mason_servers_envs == "" then return {} end

	local servers = split(mason_servers_envs, ":")
	for _, server in ipairs(servers) do
		local opts = split(server, ";")
		local serv = {}
		table.insert(serv, opts[1])
		if opts[2] ~= nil then
			serv.version = opts[2]
		end
		if opts[3] ~= nil then
			serv.auto_update = true
		end
		table.insert(result, serv)
	end

	-- print('servers : ')
	-- vim.pretty_print(result)

	return result
end

mason_installer.setup {
	auto_update = false,
	ensure_installed = get_mason_env_servers()
	-- ensure_installed = { -- vuels
	-- 	{'vim-language-server'},
	-- 	{'lua-language-server'},
	-- 	{'stylua'},
	-- 	{'luacheck'},

	-- 	{'ltex-ls'},

	-- 	{'typescript-language-server'},
	-- 	{'css-lsp'},
	-- 	{'cssmodules-language-server'},
	-- 	{'vetur-vls'},
	-- 	{'eslint-lsp'},

	-- 	{'pyright'},

	-- 	{'dockerfile-language-server'},
	-- 	{'jdtls', version = 'v1.17.0'},
	-- 	{'omnisharp', version = 'v1.39.2'},
	-- }
}
