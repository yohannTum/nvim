return {
	'stevearc/conform.nvim',
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<Leader>f",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end,
			mode = "",
			desc = "LSP Format",
		}
	},
	--@type conform.setupOpts
	-- This will provide type hinting with LuaLS
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		notify_on_error = true,
		-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#options
		formatters_by_ft = {
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier"},
			javascriptreact = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			css = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			json = { "prettierd", "prettier" },
			yaml = { "prettierd", "prettier" },
			markdown = { "prettierd", "prettier" },
			c = { 'clang_format' },
		},
		formatters = {
			-- :h conform-formatters
			clang_format = {
			},
		}
	},
}
