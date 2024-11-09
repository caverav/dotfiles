require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
local function termcodes(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {
	i = {
		-- go to  beginning and end
		["<C-b>"] = { "<ESC>^i", "beginning of line" },
		["<C-e>"] = { "<End>", "end of line" },

		-- navigate within insert mode
		["<C-h>"] = { "<Left>", "move left" },
		["<C-l>"] = { "<Right>", "move right" },
		["<C-j>"] = { "<Down>", "move down" },
		["<C-k>"] = { "<Up>", "move up" },
	},

	n = {
		["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },

		-- switch between windows
		["<C-h>"] = { "<C-w>h", "window left" },
		["<C-l>"] = { "<C-w>l", "window right" },
		["<C-j>"] = { "<C-w>j", "window down" },
		["<C-k>"] = { "<C-w>k", "window up" },

		-- save
		["<C-s>"] = { "<cmd> w <CR>", "save file" },

		-- Copy all
		["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

		-- line numbers
		["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
		["<leader>ra"] = { "<cmd> set rnu! <CR>", "toggle relative number" },

		-- update nvchad
		["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "update nvchad" },

		["<leader>tt"] = {
			function()
				require("base46").toggle_theme()
			end,
			"toggle theme",
		},

		-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
		-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
		-- empty mode is same as using <cmd> :map
		-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

		-- new buffer
		["<leader>b"] = { "<cmd> enew <CR>", "new buffer" },
	},

	t = { ["<C-x>"] = { termcodes("<C-\\><C-N>"), "escape terminal mode" } },

	v = {
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
	},

	x = {
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
	},
}

M.tabufline = {
	plugin = true,

	n = {
		-- cycle through buffers
		["<TAB>"] = {
			function()
				require("nvchad.tabufline").tabuflineNext()
			end,
			"goto next buffer",
		},

		["<S-Tab>"] = {
			function()
				require("nvchad.tabufline").tabuflinePrev()
			end,
			"goto prev buffer",
		},

    ["<A-1>"] = {
      "<cmd>buffer 1<CR>", "goto buffer 1"
    },

    ["<A-2>"] = {
      "<cmd>buffer 2<CR>", "goto buffer 2"
    },
    ["<A-3>"] = {
      "<cmd>buffer 3<CR>", "goto buffer 3"
    },
    ["<A-4>"] = {
      "<cmd>buffer 4<CR>", "goto buffer 4"
    },
    ["<A-5>"] = {
      "<cmd>buffer 5<CR>", "goto buffer 5"
    },
    ["<A-6>"] = {
      "<cmd>buffer 6<CR>", "goto buffer 6"
    },
    ["<A-7>"] = {
      "<cmd>buffer 7<CR>", "goto buffer 7"
    },
    ["<A-8>"] = {
      "<cmd>buffer 8<CR>", "goto buffer 8"
    },
    ["<A-9>"] = {
      "<cmd>buffer 9<CR>", "goto buffer 9"
    },

    ["<A-,>"] = {
      "<cmd>BufferPrevious<CR>", "goto previous buffer"
    },
    ["<A-.>"] = {
      "<cmd>BufferNext<CR>", "goto next buffer"
    },


		-- pick buffers via numbers
		["<Bslash>"] = { "<cmd> TbufPick <CR>", "Pick buffer" },

		-- close buffer + hide terminal buffer
		["<leader>x"] = {
			function()
				require("nvchad.tabufline").close_buffer()
			end,
			"close buffer",
		},
	},
}

M.comment = {
	plugin = true,

	-- toggle comment in both modes
	n = {
		["<leader>/"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"toggle comment",
		},
	},

	v = {
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"toggle comment",
		},
	},
}

M.lspconfig = {
	plugin = true,

	-- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

	n = {
		["gD"] = {
      "<cmd>lua vim.lsp.buf.declaration()<CR>", "lsp declaration"
		},

		["gd"] = {
      "<cmd>lua vim.lsp.buf.definition()<CR>", "lsp definition"
		},

		["K"] = {
      "<cmd>lua vim.lsp.buf.hover()<CR>", "lsp hover"
		},

		["gi"] = {
      "<cmd>lua vim.lsp.buf.implementation()<CR>", "lsp implementation"
		},

		["<leader>ls"] = {
      "<cmd>lua vim.lsp.buf.signature_help()<CR>", "lsp signature help"
		},

		["<leader>D"] = {
      "<cmd>lua vim.lsp.buf.type_definition()<CR>", "lsp type definition"
		},

		["<leader>rn"] = {
      "<cmd>lua vim.lsp.buf.rename()<CR>", "lsp rename"
		},

		["<leader>ca"] = {
      "<cmd>lua vim.lsp.buf.code_action()<CR>", "lsp code action"
		},

		["gr"] = {
      "<cmd>lua vim.lsp.buf.references()<CR>", "lsp references"
		},

		["<leader>f"] = {
			function()
				vim.diagnostic.open_float()
			end,
			"floating diagnostic",
		},

		["[d"] = {
			function()
				vim.diagnostic.goto_prev()
			end,
			"goto prev",
		},

		["d]"] = {
			function()
				vim.diagnostic.goto_next()
			end,
			"goto_next",
		},

		["<leader>q"] = {
			function()
				vim.diagnostic.setloclist()
			end,
			"diagnostic setloclist",
		},

		["<leader>fm"] = {
			function()
				vim.lsp.buf.formatting({})
			end,
			"lsp formatting",
		},

		["<leader>wa"] = {
			function()
				vim.lsp.buf.add_workspace_folder()
			end,
			"add workspace folder",
		},

		["<leader>wr"] = {
			function()
				vim.lsp.buf.remove_workspace_folder()
			end,
			"remove workspace folder",
		},

		["<leader>wl"] = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"list workspace folders",
		},
	},
}

M.nvimtree = {
	plugin = true,

	n = {
		-- toggle
		["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },

		-- focus
		["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
	},
}

M.telescope = {
	plugin = true,

	n = {
		-- find
		["<leader>ff"] = { "<cmd> lua require('telescope.builtin').find_files()<CR>", "find files" },
		["<leader>fa"] = { "<cmd> lua require('telescope.builtin').find_files({no_ignore=true})<CR>", "find all" },
		["<leader>fw"] = { "<cmd> lua require('telescope.builtin').live_grep()<CR>", "live grep" },
		["<leader>fb"] = { "<cmd> lua require('telescope.builtin').buffers()<CR>", "find buffers" },
		["<leader>fh"] = { "<cmd> lua require('telescope.builtin').help_tags()<CR>", "help page" },
		["<leader>fo"] = { "<cmd> lua require('telescope.builtin').oldfiles()<CR>", "find oldfiles" },
		["<leader>tk"] = { "<cmd> lua require('telescope.builtin').keymaps()<CR>", "show keys" },

		-- neorg
		-- ["<leader>fn"] = { "<cmd> Telescope neorg switch_workspace <CR>", "neorg switch workspace" },

		-- git
		["<leader>cm"] = { "<cmd> lua require('telescope.builtin').git_commits()<CR>", "git commits" },
		["<leader>gt"] = { "<cmd> lua require('telescope.builtin').git_status()<CR>", "git status" },

		-- pick a hidden term
		["<leader>pt"] = { "<cmd> lua require('telescope.builtin').terms()<CR>", "pick hidden term" },

		-- theme switcher
		["<leader>th"] = { "<cmd>Telescope themes<CR>", "nvchad themes" },
	},
}

M.nvterm = {
	plugin = true,

	t = {
		-- toggle in terminal mode
		["<A-i>"] = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"toggle floating term",
		},

		["<A-h>"] = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"toggle horizontal term",
		},

		["<A-v>"] = {
			function()
				require("nvterm.terminal").toggle("vertical")
			end,
			"toggle vertical term",
		},
	},

	n = {
		-- toggle in normal mode
		["<A-i>"] = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"toggle floating term",
		},

		["<A-h>"] = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"toggle horizontal term",
		},

		["<A-v>"] = {
			function()
				require("nvterm.terminal").toggle("vertical")
			end,
			"toggle vertical term",
		},

		-- new

		-- ["<leader>h"] = {
		--   function()
		--     require("nvterm.terminal").new "horizontal"
		--   end,
		--   "new horizontal term",
		-- },
		--
		-- ["<leader>v"] = {
		--   function()
		--     require("nvterm.terminal").new "vertical"
		--   end,
		--   "new vertical term",
		-- },
	},
}

M.whichkey = {
	plugin = true,

	n = {
		["<leader>wK"] = {
			function()
				vim.cmd("WhichKey")
			end,
			"which-key all keymaps",
		},
		["<leader>wk"] = {
			function()
				local input = vim.fn.input("WhichKey: ")
				vim.cmd("WhichKey " .. input)
			end,
			"which-key query lookup",
		},
	},
}

M.blankline = {
	plugin = true,

	n = {
		["<leader>cc"] = {
			function()
				local ok, start = require("indent_blankline.utils").get_current_context(
					vim.g.indent_blankline_context_patterns,
					vim.g.indent_blankline_use_treesitter_scope
				)

				if ok then
					vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
					vim.cmd([[normal! _]])
				end
			end,

			"Jump to current_context",
		},
	},
}

-- This function applies mappings from the M table
local function apply_mappings(mappings)
  local map = vim.keymap.set

  -- Iterate through each key in the mappings table
  for mode, mode_mappings in pairs(mappings) do
    if type(mode_mappings) == "table" then
      for lhs, rhs_info in pairs(mode_mappings) do
        local rhs = rhs_info[1]
        local opts = rhs_info.opts or {}

        -- Check if rhs is valid
        if type(rhs) == "string" then
          -- Apply the mapping using vim.keymap.set
          map(mode, lhs, rhs, opts)
        else
          print("Warning: Invalid rhs type for mapping", lhs)
        end
      end
    else
      print("Warning: Expected table for mode", mode, "but got", type(mode_mappings))
    end
  end
end

local C = {}

C.general = {
	n = {
		[";"] = { ":", "command mode", opts = { nowait = true } },
	},

	i = {
		["jk"] = { "<ESC>", "escape vim" },
	},
}

C.venn = {
	n = {
		["vn"] = {
			function()
				require("custom.plugins.venn").toggle_maps()
			end,
			"toggle venn mappings",
		},
	},
}

C.truzen = {
	n = {
		["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "truzen ataraxis" },
		["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "truzen minimal" },
		["<leader>tf"] = { "<cmd> TZFocus <CR>", "truzen focus" },
	},
}

C.projects = {
	n = {
		["<C-p>"] = { "<cmd> Telescope projects <CR>", "Switch Projects" },
	},
}

C.Aerial = {
	n = {
		["<leader>a"] = { "<cmd>AerialToggle!<CR>", "Toggle Aerial" },
		["{"] = { "<cmd>AerialPrev<CR>", "Aerial Previous" },
		["}"] = { "<cmd>AerialNext<CR>", "Aerial Next" },
		["[["] = { "<cmd>AerialPrevUp<CR>", "Aerial Prev Up Tree" },
		["]]"] = { "<cmd>AerialNextUp<CR>", "Aerial Next Up Tree" },
	},
}

C.treesitter = {
	n = {
		["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "find media" },
	},
}

C.shade = {
	n = {
		["<leader>s"] = {
			function()
				require("shade").toggle()
			end,

			"toggle shade.nvim",
		},
	},
}

C.navigation = {
	n = {
		["H"] = { "^", "beginning of line" },
		["L"] = { "$", "end of line" },
	},
}

C.Barbar = {
	n = {
		-- ["<A-.>"] = { ":BufferNext<CR>", "Next Buffer" },
		-- ["<A-,>"] = { ":BufferPrevious<CR>", "Previous Buffer" },
		-- ["<A-1>"] = { ":BufferGoto 1<CR>", "Goto buffer 1" },
		-- ["<A-2>"] = { ":BufferGoto 2<CR>", "Goto buffer 2" },
		-- ["<A-3>"] = { ":BufferGoto 3<CR>", "Goto buffer 3" },
		-- ["<A-4>"] = { ":BufferGoto 4<CR>", "Goto buffer 4" },
		-- ["<A-5>"] = { ":BufferGoto 5<CR>", "Goto buffer 5" },
		-- ["<A-6>"] = { ":BufferGoto 6<CR>", "Goto buffer 6" },
		-- ["<A-7>"] = { ":BufferGoto 7<CR>", "Goto buffer 7" },
		-- ["<A-8>"] = { ":BufferGoto 8<CR>", "Goto buffer 8" },
		-- ["<A-9>"] = { ":BufferGoto 9<CR>", "Goto buffer 9" },
		-- ["<leader>cc"] = { ":BufferCloseAllButCurrentOrPinned<CR>", "Close all but keep current or pinned" },
		-- ["<A-0>"] = { ":BufferLast<CR>", "Goto last buffer" },
	},
}

C.Far = {
	n = {
		["<A-f>"] = { ":Far<CR>" },
	},
	i = {
		["<A-f>"] = { ":Far<CR>" },
	},
}

C.Hop = {
	n = {
		["<leader>hl"] = { ":HopLineStart<CR>" },
		["<leader>hw"] = { ":HopWordCurrentLine<CR>" },
	},
}
C.SaveFile = {
	i = {
		["<C-s>"] = {
			"<ESC>:w | lua require'notify'('Saving file ....', 'success', {title = 'System', timeout = 1000})<cr>",
			"Save file in insert mode",
			opts = { silent = true },
		},
	},
	n = {
		["<C-s>"] = {
			"<ESC>:w | silent lua require'notify'('Saving file ....', 'success', {title = 'System', timeout = 1000})<cr>",
			"Save file in normal mode",
			opts = { silent = true },
		},
	},
}

C.NvimTree = {
	n = {
		["<C-b>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
	},
}

C.Trouble = {
	n = {
		["<A-m>"] = { ":Trouble diagnostics toggle<cr>", "Open trouble window" },
	},
}
C.Telescope = {
	n = {
		["<leader>ft"] = { ":TodoTelescope<cr>", "   Open Todo Telescope" },
		["<C-g>"] = { ":Telescope live_grep<cr>", "Live grep with telescope" },
	},
}
C.PreventArrow = {
	n = {
		["<up>"] = {
			"<nop>",
			"Don't use arrow",
		},
		["<down>"] = {
			"<nop>",
			"Don't use arrow",
		},
		["<right>"] = {
			"<nop>",
			"Don't use arrow",
		},
		["<left>"] = {
			"<nop>",
			"Don't use arrow",
		},
	},
}

C.copilot = {
	n = {
		["<leader>ce"] = { "<cmd>Copilot enable<CR>", "Enable Copilot" },
		["<leader>cd"] = { "<cmd>Copilot disable<CR>", "Disable Copilot" },
	},
}

-- Apply mappings for the general, tabufline, comment, lspconfig, nvimtree, telescope, nvterm, whichkey, and blankline sections
local sections = {
  "general",
  "tabufline",
  "comment",
  "lspconfig",
  "nvimtree",
  "telescope",
  "nvterm",
  "whichkey",
  "blankline"
}

for _, section in ipairs(sections) do
  local mappings = M[section]
  if mappings then
    apply_mappings(mappings)
  else
    print("Warning: No mappings found for section", section)
  end
end

local sections = {
  "general",
  "venn",
  "truzen",
  "projects",
  "Aerial",
  "treesitter",
  "shade",
  "navigation",
  "Barbar",
  "Far",
  "Hop",
  "SaveFile",
  "NvimTree",
  "Trouble",
  "Telescope",
  "PreventArrow",
  "copilot"
}
for _, section in ipairs(sections) do
  local mappings = C[section]
  if mappings then
    apply_mappings(mappings)
  else
    print("Warning: No mappings found for section", section)
  end
end
