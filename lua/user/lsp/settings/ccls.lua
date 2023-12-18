return {
	init_options = {
		cache = {
			directory = ".ccls-cache";
		};
	},
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}
