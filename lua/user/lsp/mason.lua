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
local servers = {
	"sumneko_lua",
	"tsserver",
	"eslint",
	"pyright",
	"ltex",
	"omnisharp",
	"vimls",
	"vuels",
	"jdtls",
	"cssmodules_ls",
	"cssls",
}

local mason_lspconfig_settings = {
	ensure_installed = servers,
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
		auto_update = true,
		ensure_installed = {
			{'jdtls', version = 'v1.17.0'},
			{'omnisharp', version = 'v1.39.2'},
		}
	}
end

local ok2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok2 then return end
mason_lspconfig.setup(mason_lspconfig_settings)

local ok3, lspconfig = pcall(require, "lspconfig")
if not ok3 then return end

local opts = {}

-- TODO: :h mason-lspconfig.setup_handlers()
for _, server in pairs(servers) do
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

-- omnisharp for dotnet setup
--[[local pid = vim.fn.getpid()
local omnisharp_bin = '/home/yohann/.config/nvim/plugin/omnisharp/OmniSharp'
require("lspconfig").omnisharp.setup {
	cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
	-- environment = "netframework",
	use_mono = true,
	root_dir = function(path)
		-- Make sure an sln doesn't already exist before trying to use the nearest csproj file
		return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
	end,
	handlers = {
		['textDocument/definition'] = require('omnisharp_extended').handler
	},
	enable_editorconfig_support = true,
	enable_ms_build_load_projects_on_demand = true,
	enable_roslyn_analyzers = true,
	-- organize_imports_on_format = false,
	enable_import_completion = false,
	-- sdk_include_prereleases = true,
	-- analyze_open_documents_only = false,
	on_attach = on_attach,
	capabilities = capabilities,
}]]
