local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("lspconfig is not installed", vim.log.levels.WARN)
	return
end

require("user.lsp.neodev") -- IMPORTANT: neodev before lspconfig
require("user.lsp.mason")
require("user.lsp.handlers").setup()
