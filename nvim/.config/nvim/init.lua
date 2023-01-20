vim.g.airline_powerline_fonts = 1
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_transparency = 0.2
vim.g.neovide_no_idle = true
vim.g.neovide_cursor_vfx_particle_density = 10.0
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_confirm_quit = true
vim.o.guifont = "UbuntuMono Nerd Font"
if vim.g.neovide == true then
	vim.api.nvim_set_keymap(
		"n",
		"<C-+>",
		":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
		{ silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-->",
		":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
		{ silent = true }
	)
	vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end
-- vim.g.neovide_floating_blur_amount_y = 20
-- vim.g.neovide_floating_blur_amount_x = 20
vim.defer_fn(function()
	pcall(require, "impatient")
end, 0)

require("core")
require("core.options")
-- setup packer + plugins
--
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
	print("Cloning packer ..")
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })

	-- install plugins + compile their configs
	vim.cmd("packadd packer.nvim")
	require("plugins")
	vim.cmd("PackerSync")

	-- install binaries from mason.nvim & tsparsers
	vim.api.nvim_create_autocmd("User", {
		pattern = "PackerComplete",
		callback = function()
			vim.cmd("bw | silent! MasonInstallAll") -- close packer window
			require("packer").loader("nvim-treesitter")
		end,
	})
end

pcall(require, "custom")

require("core.utils").load_mappings()
