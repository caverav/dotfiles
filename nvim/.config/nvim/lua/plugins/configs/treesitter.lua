local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
	return
end


local options = {
	-- ensure_installed = {
	--   "lua",
	-- },
	auto_install = true,

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = {
		enable = true,
	},
}

-- check for any override

treesitter.setup(options)
