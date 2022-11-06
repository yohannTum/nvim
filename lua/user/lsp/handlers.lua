local M = {}

-- TODO: backfill this to template
M.setup = function()
	-- :h diagnostic-highlights
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = true,
		-- show signs
		signs = false,
		-- signs = {
		-- 	active = signs
		-- },
		update_in_insert = false,
		underline = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "none", -- single, double, rounded, solid, shadow, {...}
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	-- 	border = "rounded",
	-- })

	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	-- 	border = "rounded",
	-- })
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
		augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		]],
			false
		)
	end
end

local function optsdesc(desc)
	return { desc = desc, noremap = true, silent = true }
end

local function lsp_keymaps(bufnr)
	local bufkeymap = vim.api.nvim_buf_set_keymap
	-- local opts = { noremap = true, silent = true }

	bufkeymap(bufnr, 'n', '<leader>te', ':lua vim.diagnostic.open_float()<CR>',
		optsdesc('LSP diagnostic float'))
	bufkeymap(bufnr, 'n', '<Leader>tn', ':lua vim.diagnostic.goto_next()<CR>',
		optsdesc('LSP go next'))
	bufkeymap(bufnr, 'n', '<Leader>tp', ':lua vim.diagnostic.goto_prev()<CR>',
		optsdesc('LSP go prev'))
	bufkeymap(bufnr, 'n', '<Leader>tq', ':lua vim.diagnostic.setloclist()<CR>',
		optsdesc('LSP local list diagnostic'))
	bufkeymap(bufnr, 'n', '<Leader>tQ', ':lua vim.diagnostic.setqflist()<CR>',
		optsdesc('LSP quickfix list diagnostic'))

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	-- dotnet specific telescope definition
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', "<cmd>lua require('omnisharp_extended').lsp_definitions()<CR>", opts)
	bufkeymap(bufnr, 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>',
		optsdesc('LSP go definition'))
	bufkeymap(bufnr, 'n', 'gD', ':lua vim.lsp.buf.declaration()<CR>',
		optsdesc('LSP go declaration'))
	bufkeymap(bufnr, 'n', '<Leader>th', ':lua vim.lsp.buf.hover()<CR>',
		optsdesc('LSP hover'))
	bufkeymap(bufnr, 'n', 'gi', ':lua vim.lsp.buf.implementation()<CR>',
		optsdesc('LSP implementation'))
	bufkeymap(bufnr, 'n', '<Leader>ts', ':lua vim.lsp.buf.signature_help()<CR>',
		optsdesc('LSP signature help'))
	-- bufkeymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { desc = 'LSP add workspace folder', noremap = true, silent = true })
	-- bufkeymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { desc = 'LSP remove workspace folder', noremap = true, silent = true })
	bufkeymap(bufnr, 'n', '<Leader>ti',
		'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
		optsdesc('LSP inspect ???'))
	bufkeymap(bufnr, 'n', '<Leader>td', ':lua vim.lsp.buf.type_definition()<CR>',
		optsdesc('LSP type definition'))
	bufkeymap(bufnr, 'n', '<Leader>tR', ':lua vim.lsp.buf.rename()<CR>',
		optsdesc('LSP rename'))
	bufkeymap(bufnr, 'n', '<Leader>tc', ':lua vim.lsp.buf.code_action()<CR>',
		optsdesc('LSP code action'))
	bufkeymap(bufnr, 'n', '<Leader>tr', ':lua vim.lsp.buf.references()<CR>',
		optsdesc('LSP references'))
	bufkeymap(bufnr, 'n', '<Leader>f', ':lua vim.lsp.buf.formatting()<CR>',
		optsdesc('LSP formatting'))
	bufkeymap(bufnr, 'v', '<Leader>f', ':lua vim.lsp.buf.range_formatting()<CR>',
		optsdesc('LSP formatting'))

	-- Telescope
	local telescope_ok, _ = pcall(require, "telescope")
	if telescope_ok then
		bufkeymap(bufnr, 'n', '<Leader>/r', ':Telescope lsp_references<CR>', optsdesc('LSP Find References'))
		-- bufkeymap(bufnr, 'n', '<Leader>/r', ':Telescope lsp_incoming_calls<CR>', optsdesc('LSP incoming calls'))
		-- bufkeymap(bufnr, 'n', '<Leader>/r', ':Telescope lsp_outgoing_calls<CR>', optsdesc('LSP outgoing calls'))
		bufkeymap(bufnr, 'n', '<Leader>/t', ':Telescope lsp_type_definitions<CR>', optsdesc('LSP type definitions'))
		bufkeymap(bufnr, 'n', '<Leader>/i', ':Telescope lsp_implementations<CR>', optsdesc('LSP implementation'))
		bufkeymap(bufnr, 'n', '<Leader>/d', ':Telescope lsp_definitions<CR>', optsdesc('LSP definitions'))
		bufkeymap(bufnr, 'n', '<Leader>/ws', ':Telescope lsp_workspace_symbols<CR>', optsdesc('LSP workspace symbols'))
		bufkeymap(bufnr, 'n', '<Leader>/wd', ':Telescope lsp_dynamic_workspace_symbols<CR>',
			optsdesc('LSP dynamic workspace symbols'))
	end
end

local function lsp_whichkey(bufnr)
	local whichkey_status, whichkey = pcall(require, "which-key")
	if whichkey_status then
		whichkey.register({["<Leader>t"] = {name = "LSP"}}, {buffer = bufnr})
	end
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.resolved_capabilities.documentFormattingProvider = false
	end
	lsp_whichkey(bufnr)
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true -- cssls?

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then return end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
