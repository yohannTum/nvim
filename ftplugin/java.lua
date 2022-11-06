local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

-- Determine OS
local home = os.getenv("HOME")
if vim.fn.has("mac") == 1 then
	WORKSPACE_PATH = home .. "/workspace/"
	CONFIG = "mac"
elseif vim.fn.has("unix") == 1 then
	WORKSPACE_PATH = home .. "/workspace/"
	CONFIG = "linux"
else
	print("Unsupported system")
end

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		'java', -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		'-Xms1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		-- 💀
		'-jar', vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

		-- 💀
		"-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. CONFIG,

		-- 💀
		-- See `data directory configuration` section in the README
		-- '-data', '$1',
		'-data', workspace_dir,
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'main.java' }),
	-- capabilities = vim.lsp.protocol.make_client_capabilities(), -- old
	capabilities = require("user.lsp.handlers").capabilities,
	-- on_attach = require("user.lsp.handlers").on_attach,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
		}
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {}
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.

-- require("user.lsp.handlers").on_attach()

-- local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap("n", "<leader>te", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"gl",
-- 	'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
-- 	opts)
-- vim.api.nvim_set_keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
-- vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)



local keymap = vim.api.nvim_set_keymap
local function optsdesc(desc)
	return { desc = desc, noremap = true, silent = true }
end

keymap('n', '<leader>te', ':lua vim.diagnostic.open_float()<CR>',
	optsdesc('LSP diagnostic float'))
keymap('n', '<Leader>tn', ':lua vim.diagnostic.goto_next()<CR>',
	optsdesc('LSP go next'))
keymap('n', '<Leader>tp', ':lua vim.diagnostic.goto_prev()<CR>',
	optsdesc('LSP go prev'))
keymap('n', '<Leader>tq', ':lua vim.diagnostic.setloclist()<CR>',
	optsdesc('LSP local list diagnostic'))
keymap('n', '<Leader>tQ', ':lua vim.diagnostic.setqflist()<CR>',
	optsdesc('LSP quickfix list diagnostic'))

-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
-- dotnet specific telescope definition
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', "<cmd>lua require('omnisharp_extended').lsp_definitions()<CR>", opts)
keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>',
	optsdesc('LSP go definition'))
keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>',
	optsdesc('LSP go declaration'))
keymap('n', '<Leader>th', ':lua vim.lsp.buf.hover()<CR>',
	optsdesc('LSP hover'))
keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>',
	optsdesc('LSP implementation'))
keymap('n', '<Leader>ts', ':lua vim.lsp.buf.signature_help()<CR>',
	optsdesc('LSP signature help'))
-- bufkeymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { desc = 'LSP add workspace folder', noremap = true, silent = true })
-- bufkeymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { desc = 'LSP remove workspace folder', noremap = true, silent = true })
keymap('n', '<Leader>ti',
	'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
	optsdesc('LSP inspect ???'))
keymap('n', '<Leader>td', ':lua vim.lsp.buf.type_definition()<CR>',
	optsdesc('LSP type definition'))
keymap('n', '<Leader>tR', ':lua vim.lsp.buf.rename()<CR>',
	optsdesc('LSP rename'))
keymap('n', '<Leader>tc', ':lua vim.lsp.buf.code_action()<CR>',
	optsdesc('LSP code action'))
keymap('n', '<Leader>tr', ':lua vim.lsp.buf.references()<CR>',
	optsdesc('LSP references'))
keymap('n', '<Leader>f', ':lua vim.lsp.buf.formatting()<CR>',
	optsdesc('LSP formatting'))

require('jdtls').start_or_attach(config)
