local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍ ",
			package_pending = "◍ ",
			package_uninstalled = "◍ ",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

local ok, mason = pcall(require, "mason")
if not ok then return end
mason.setup(settings)

-- :h lspconfig-server-configurations
-- local servers = {}

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

local mason_lspconfig_settings = {
	ensure_installed = {},
	automatic_installation = {
		exclude = {
			"rome"
		}
	}
}

-- specify versions of lsp servers :
local mason_installer_status, mason_installer = pcall(require, "mason-tool-installer")
if mason_installer_status then
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
end

local ok2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok2 then return end
mason_lspconfig.setup(mason_lspconfig_settings)

local ok3, lspconfig = pcall(require, "lspconfig")
if not ok3 then return end

local opts = {}

for _, server in pairs(mason_lspconfig.get_installed_servers()) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	-- server = vim.split(server, "@")[1] -- in case of a version with an '@'?

	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)

	-- if server == "cssls" then
	-- 	opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
	-- end

	if has_custom_opts then
		-- print('opts of : ' .. server)
		-- require("user.utils.print").print_table(server_custom_opts)
		opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end

	if server == "jdtls" then goto continue end

	lspconfig[server].setup(opts)
	::continue::
end

-- vim.g['lsp_diagnostics_echo_cursor'] = 1 -- usefull still?
