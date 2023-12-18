local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
if not lsp_signature_ok then return end

lsp_signature.setup({
	bind = true,
	hint_enable = false,
	timer_interval = 20,
	extra_trigger_chars = {"(", ","},
	floating_window = true,
	floating_window_above_cur_line = true,
})
