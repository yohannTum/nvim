local ok, mason = pcall(require, "mason")
if not ok then return end

mason.setup({
	ui = {
		border = "none",
		icons = {
			package_installed = "◍ ",
			package_pending = "◍ ",
			package_uninstalled = "◍ ",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
})
