return {
	cmd = { "typescript-language-server", "--stdio" },
	-- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
	hostInfo = { hostInfo = "neovim" },
	root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}
