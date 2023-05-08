local icons = require("custom.plugins.icons")

local options = {
	load = {
		["core.defaults"] = {},

		["core.presenter"] = {
			config = {
				zen_mode = "truezen",
			},
		},

		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/Documents/notes",
					trabajo = "~/Documents/notes/trabajo",
					usm = "~/Documents/notes/usm",
					hacking = "~/Documents/notes/hacking",
				},
				default_workspace = "notes",
			},
		},

		["core.concealer"] = {
			config = {
				icons = {
					todo = icons.todo,
					list = icons.list,
					heading = icons.heading,
				},
				dim_code_blocks = {
					width = "content", -- Default is "fullwidth"

					padding = {
						left = 10,
						right = 10,
					},
				},
			},
		},

		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},

		["core.integrations.telescope"] = {},

		["core.integrations.treesitter"] = {},

		["core.integrations.nvim-cmp"] = {},

		-- ["core.neorg.qol.toc"] = {
		-- 	config = {
		-- 		keybinds = {
		-- 			toggle = "<leader>o",
		-- 		},
		-- 	},
		-- },

		-- ["core.neorg.qol.todo_items"] = {
		-- 	config = {
		-- 		keybinds = {
		-- 			toggle = "<leader>t",
		-- 		},
		-- 	},
		-- },

		["core.export"] = {
			config = {
				default_keybinds = true,
				default_keybinds_options = {
					export_on_save = true,
				},
			},
		},

		["core.export.markdown"] = {},

		["core.syntax"] = {},

		-- ["core.norg.esupports.indent"] = {
		--   config = {
		--     format_on_enter = false,
		--     format_on_escape = false,
		--   },
		-- },
	},
}

local M = {}

M.setup = function()
	local present, neorg = pcall(require, "neorg")

	if not present then
		return
	end

	vim.opt.foldenable = false
	vim.g.neorg_indent = true

	neorg.setup(options)
end

-- autocmds
-- pretty up norg ft!

M.autocmd = function()
	local opt = vim.opt_local

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "norg",
		callback = function()
			opt.number = false
			opt.foldlevel = 10
			opt.signcolumn = "yes:2"
		end,
	})
end

return M
