----------- new config
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("lspconfig is not installed", vim.log.levels.WARN)
	return
end

require("user.lsp.mason")
require("user.lsp.handlers").setup()


---------- old config

-- local function setup_diags()
-- 	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
-- 		vim.lsp.diagnostic.on_publish_diagnostics,
-- 		{
-- 			virtual_text = true,
-- 			signs = false,
-- 			update_in_insert = false,
-- 			underline = false,
-- 		}
-- 	)
-- end
--
-- setup_diags()
