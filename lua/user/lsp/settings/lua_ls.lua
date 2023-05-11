local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
-- trying to get lsp working with extern libraries (busted for example)
-- no solutions? wanna cry : https://www.reddit.com/r/awesomewm/comments/10yfgoe/configuring_awesomewm_using_neovim_nvimlsp/
-- or : https://www.reddit.com/r/awesomewm/comments/xjx5td/comment/ipb6dmx
-- https://wiki.nikiv.dev/programming-languages/lua
-- https://github.com/LuaLS/lua-language-server/wiki/Libraries#automatically-applying
-- https://github.com/LuaLS/lua-language-server/wiki/Configuration-File#custom-config-file
-- You will have to adjust your values according to your system
--[[settings = {
	Lua = {
		runtime = {
			version = 'Lua 5.3',
			path = {
				'?.lua',
				'?/init.lua',
				vim.fn.expand '~/.luarocks/share/lua/5.3/?.lua',
				vim.fn.expand '~/.luarocks/share/lua/5.3/?/init.lua',
				'/usr/share/5.3/?.lua',
				'/usr/share/lua/5.3/?/init.lua'
			}
		},
		workspace = {
			library = {
				vim.fn.expand '~/.luarocks/share/lua/5.3',
				'/usr/share/lua/5.3'
			}
		}
	}
}]]



--[[ logs : (luarc automatically generated from nvim-treesitter plugin in .local/share/.../nvim-treesitter
{
    "workspace.library": [
        "${3rd}/luv/library",
        "/home/yohann/.local/share/nvim/site/pack/packer/start/neodev.nvim/types/stable",
        "/home/yohann/neovim-0.8.3/share/nvim/runtime/lua",
        "/home/yohann/.local/share/nvim/site/pack/packer/start/nvim-treesitter/lua",
        "${3rd}/luassert/library"
    ]
}
--]]



return {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = runtime_path },
			diagnostics = {
				enable = true,
				globals = { "vim", "describe", "it", "before_each", "after_each", "ok" },
			},
			workspace = {
				-- library = vim.api.nvim_get_runtime_file("", true),
				library = {
				-- 	--  nothing so far to link plenary.nvim/busted
				-- 	["${3rd}/luv/library"] = true,
				-- 	["/home/yohann/luarocks/build/share/lua/5.3"] = true,
				-- 	[vim.fn.expand("~/neovim-0.8.3/src/nvim/lua")] = true,
				-- 	["/home/yohann/neovim-0.8.3/.deps/usr/share/lua/5.1"] = true,
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			telemetry = {
				enable = false,
			},
			completion = {
				callSnippet = "Replace"
			},
		},
	},
}
