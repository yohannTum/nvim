return {
	'sainnhe/gruvbox-material',
	tag = "v1.2.5",
	config = function ()
		--[[ background colors :
			#1d2021
			#282828
			#32302f
			#32302f
    	]]
		vim.cmd("let g:gruvbox_material_background = 'medium'") -- soft, medium, hard
		vim.cmd("let g:gruvbox_material_foreground = 'original'") -- material, mix, original
		-- vim.cmd("let g:airline_theme = 'gruvbox_material'")
		---------vim.cmd("let g:gruvbox_material_ui_contrast = 'hard'")
		vim.cmd("let g:gruvbox_material_ui_contrast = 'hard'")
		vim.cmd("let g:gruvbox_material_colors_override = {'bg0': ['#272822', '234']}") -- monokai bg
		-- vim.cmd("let g:gruvbox_material_colors_override = {'bg0': ['#1d2021', '234']}") -- blueish dark bg
		-- vim.cmd("let g:gruvbox_material_colors_override = {'bg0': ['#111213', '234']}") -- ultra dark bg
		vim.cmd("let g:gruvbox_material_statusline_style = 'original'")
		vim.cmd("let g:gruvbox_material_diagnostic_virtual_text = 'colored'") -- soft, medium, hard

		vim.cmd("colorscheme gruvbox-material")
		-- vim.cmd("let g:gruvbox_material_transparent_background = 0")
	end
}
