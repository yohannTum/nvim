local function optsdesc(desc)
	return { desc = desc, noremap = true, silent = true }
end

return {
	'stevearc/conform.nvim',
	event = { "BufReadPre", "BufNewFile" },
	config = function ()
		local conform_ok, conform = pcall(require,"conform")
		if not conform_ok then return end
		conform.setup({
			formatters_by_ft = {
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
			}
		})
		vim.keymap.set({"n", "v"}, "<Leader>f", function ()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, optsdesc('preview hunks'))
	end
}
