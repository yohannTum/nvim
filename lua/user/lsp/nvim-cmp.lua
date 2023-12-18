
local cmp = require("cmp")
local luasnip = require("luasnip")

local kind_icons = {
	-- Text = "",
	Text = "",
	-- Text = " ",
	-- Method = "m",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	-- Snippet = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	-- Constant = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
} -- find more here: https://www.nerdfonts.com/cheat-sheet

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
	CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
	mapping = {
		['<Enter>'] = cmp.mapping.confirm({ select = false }),
		['<C-n>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-l>'] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		['<C-h>'] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		['<C-c>'] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<A-k>"] = cmp.mapping.scroll_docs(-4),
		["<A-j>"] = cmp.mapping.scroll_docs(4),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
				nvim_lua = "[NVIM_LUA]",
				-- latex_symbols = "[LaTeX]",
			})[entry.source.name]
			return vim_item
		end
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "gh_issues" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path", option = { trailing_slash = true } },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 5 },
	},
	experimental = {
		-- native_menu = false,
		-- ghost_text = true,
	}
}
