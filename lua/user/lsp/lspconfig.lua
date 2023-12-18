local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then return end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	print("lspconfig not installed")
	return
end

local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}

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

require("user.lsp.handlers").setup()
