-- reloads every packages under lua/user

function _G.ReloadConfig()
	for name, _ in pairs(package.loaded) do
		if name:match('^user') and not
			(name:match('nvim%-tree')
			-- or name:match('whichkey')
			-- or name:match('keymaps')
			) then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

function _G.ReloadConfigPrint()
	for name, _ in pairs(package.loaded) do
		if name:match('^user') and not
			(name:match("nvim%-tree")
			or name:match("whichkey")
			or name:match('which%-key')
			)
		then
			print('package.loaded[\'' .. name .. '\'] = nil')
		end
	end
end

vim.cmd "command! ReloadConfig lua ReloadConfig()"
