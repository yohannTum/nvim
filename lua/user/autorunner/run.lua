local keymap = vim.api.nvim_set_keymap
-- local opts = { noremap = true, silent = true }

local function optsdesc(desc)
	return { desc = desc, noremap = true, silent = true }
end

local whichkey_status, whichkey = pcall(require, "which-key")
if whichkey_status then
	-- whichkey.register({ ["<Leader>t"] = { name = "LSP" } }, { buffer = bufnr })
	whichkey.register({ ["<Leader>r"] = { name = "Run" } })
end

local runCommand = ""

function RunRun()
	if runCommand == "" or runCommand == nil then
		vim.ui.input({ prompt = 'Run Command: ', completion = 'shellcmd'}, function(input)
			runCommand = input
		end)
		if not runCommand == "" then
			keymap('n', '<Leader>rr', ':lua RunRun()<CR>', optsdesc("Run"))
		end
	else
		vim.api.nvim_command("!" .. runCommand)
	end
end

function RunChangeRun()
	vim.ui.input({ prompt = 'Run Command: ', default = runCommand, completion = 'shellcmd', cancelreturn = runCommand }, function(input)
		runCommand = input
	end)
end

keymap('n', '<Leader>rr', ':lua RunRun()<CR>', optsdesc("* Run"))
keymap('n', '<Leader>ra', ':lua RunChangeRun()<CR>', optsdesc("Change Run command"))
