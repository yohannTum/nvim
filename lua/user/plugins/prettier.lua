local null_ls_ok, null_ls = pcall(require,"null-ls")
if not null_ls_ok then return end
-- builtins :
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

-- local completion = null_ls.builtins.completion

-- local code_action = null_ls.builtins.code_actions
-- local hover = null_ls.builtins.hover
-- local test = null_ls.builtins._test

null_ls.setup({
	sources = {
		-- diagnostics.eslint,

		-- formatting.prettier,

		-- formatting.stylua,
		-- diagnostics.luacheck,

		-- completion.spell,
		-- null_ls.builtins.completion.spell,
	},
})
