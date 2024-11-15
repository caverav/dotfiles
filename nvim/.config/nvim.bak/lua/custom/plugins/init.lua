local overrides = require("custom.plugins.overrides")

return {

	----------------------------------------- default plugins ------------------------------------------
	["NvChad/ui"] = {
		after = "base46",
		module = "nvchad_ui",
		config = function()
			local present, nvchad_ui = pcall(require, "nvchad_ui")

			if present then
				nvchad_ui.setup()
			end
		end,
	},

	["MunifTanjim/nui.nvim"] = {},
	["supermaven-inc/supermaven-nvim"] = {
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<Tab>",
					clear_suggestion = "<C-]>",
					accept_word = "<C-j>",
				},
				ignore_filetypes = { cpp = true },
				color = {
					suggestion_color = "#f00fff",
					cterm = 244,
				},
				log_level = "info", -- set to "off" to disable logging completely
				disable_inline_completion = true, -- disables inline completion for use with cmp
				disable_keymaps = false, -- disables built in keymaps for more manual control
			})
		end,
	},

	-- ["MeanderingProgrammer/render-markdown.nvim"] = {
	--   config = function()
	--     require("custom.plugins.dressing")
	--   end,
	-- },

	["goolord/alpha-nvim"] = {
		disable = false,
		override_options = overrides.alpha,
	},

	["nvim-telescope/telescope.nvim"] = {
		module = "telescope",
		override_options = overrides.telescope,
	},
	["NvChad/nvterm"] = {
		override_options = overrides.nvterm,
	},

	-- override default configs
	["kyazdani42/nvim-tree.lua"] = {
		override_options = overrides.nvimtree,
	},

	["nvim-treesitter/nvim-treesitter"] = {
		override_options = overrides.treesitter,
	},

	["williamboman/mason.nvim"] = {
		override_options = overrides.mason,
	},

	["williamboman/mason-lspconfig.nvim"] = {
		config = function()
			require("custom.plugins.mason-lspconfig")
		end,
	},
	--------------------------------------------- custom plugins ----------------------------------------------
	["yetone/avante.nvim"] = {
		lazy = false,
		build = "make",
		config = function()
			require("custom.plugins.avante")
		end,
		requires = {
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"zbirenbaum/copilot.lua",
		},
	},

	["zbirenbaum/copilot.lua"] = {
		lazy = false,
		config = function()
			require("copilot").setup({
				-- panel = {
				-- 	enabled = true,
				-- 	auto_refresh = false,
				-- 	keymap = {
				-- 		jump_prev = "[[",
				-- 		jump_next = "]]",
				-- 		accept = "<CR>",
				-- 		refresh = "gr",
				-- 		open = "<M-CR>",
				-- 	},
				-- 	layout = {
				-- 		position = "bottom", -- | top | left | right
				-- 		ratio = 0.4,
				-- 	},
				-- },
				-- suggestion = {
				-- 	enabled = true,
				-- 	auto_trigger = true,
				-- 	hide_during_completion = false,
				-- 	debounce = 75,
				-- 	keymap = {
				-- 		accept = "<M-l>",
				-- 		accept_word = false,
				-- 		accept_line = true,
				-- 		next = "<M-]>",
				-- 		prev = "<M-[>",
				-- 		dismiss = "<C-]>",
				-- 	},
				-- },
				-- filetypes = {
				-- 	yaml = false,
				-- 	markdown = false,
				-- 	help = false,
				-- 	gitcommit = false,
				-- 	gitrebase = false,
				-- 	hgcommit = false,
				-- 	svn = false,
				-- 	cvs = false,
				-- 	["."] = false,
				-- },
				-- copilot_node_command = "node", -- Node.js version must be > 18.x
				-- server_opts_overrides = {},
			})
		end,
	},

	["akinsho/flutter-tools.nvim"] = {
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup({})
		end,
	},
	-- autoclose tags in html, jsx only
	["windwp/nvim-ts-autotag"] = {
		ft = { "html", "javascriptreact" },
		after = "nvim-treesitter",
		config = function()
			local present, autotag = pcall(require, "nvim-ts-autotag")

			if present then
				autotag.setup()
			end
		end,
	},

	-- format & linting
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},

	-- distraction free modes
	["Pocco81/TrueZen.nvim"] = {
		cmd = {
			"TZAtaraxis",
			"TZMinimalist",
			"TZFocus",
		},
		config = function()
			require("custom.plugins.truezen")
		end,
	},

	-- get highlight group under cursor
	["nvim-treesitter/playground"] = {
		cmd = "TSCaptureUnderCursor",
		config = function()
			require("nvim-treesitter.configs").setup()
		end,
	},

	-- I rarely use shade.nvim/autosave.nvim so made commands to enable them

	-- dim inactive windows
	["andreadev-it/shade.nvim"] = {
		module = "shade",
		config = function()
			require("custom.plugins.shade")
		end,
	},

	-- autosave
	["Pocco81/AutoSave.nvim"] = {
		module = "autosave",
		config = function()
			require("autosave").setup()
		end,
	},

	-- notes & todo stuff
	["nvim-neorg/neorg"] = {
		-- after treesitter and telescope
		after = { "nvim-treesitter", "telescope.nvim" },
		-- after = "nvim-treesitter",
		setup = function()
			require("custom.plugins.neorg").autocmd()
		end,
		config = function()
			require("custom.plugins.neorg").setup()
		end,
		run = ":Neorg sync-parsers",
		requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
	},

	-- basic diagrams for flow charts etc
	["jbyuki/venn.nvim"] = {
		module = "venn.nvim",
		config = function()
			require("custom.plugins.venn").setup()
		end,
	},

	["rmagatti/goto-preview"] = {
		config = function()
			require("goto-preview").setup({
				border = "rounded",
				default_mappings = true,
			})
		end,
	},
	["tpope/vim-surround"] = {},
	["mattn/emmet-vim"] = {},
	["terryma/vim-multiple-cursors"] = {},
	-- ["wakatime/vim-wakatime"] = {},
	["folke/trouble.nvim"] = {
		config = function()
			require("custom.plugins.trouble")
		end,
	},
	["folke/todo-comments.nvim"] = {
		config = function()
			require("custom.plugins.todo-comments")
		end,
	},
	-- ["romgrk/barbar.nvim"] = {},
	["tpope/vim-fugitive"] = {},
	["junegunn/gv.vim"] = {},
	["rcarriga/nvim-notify"] = {
		config = function()
			require("custom.plugins.notify")
		end,
	},
	["andweeb/presence.nvim"] = {
		config = function()
			require("custom.plugins.presence")
		end,
	},
	["phaazon/hop.nvim"] = {
		config = function()
			require("hop").setup({})
		end,
	},
	["folke/twilight.nvim"] = {
		config = function()
			require("custom.plugins.twilight")
		end,
	},
	["SmiteshP/nvim-navic"] = {
		requires = "neovim/nvim-lspconfig",
		config = function()
			require("custom.plugins.navic")
		end,
	},
	["stevearc/dressing.nvim"] = {
		config = function()
			require("custom.plugins.dressing")
		end,
	},
	["romgrk/barbar.nvim"] = {},
	["xiyaowong/nvim-transparent"] = {
		enable = true, -- boolean: enable transparent
		extra_groups = { -- table/string: additional groups that should be cleared
			"BufferLineTabClose",
			"BufferlineBufferSelected",
			"BufferLineFill",
			"BufferLineBackground",
			"BufferLineSeparator",
			"BufferLineIndicatorSelected",
		},
		exclude = {}, -- table: groups you don't want to clear
	},
	["nvim-lualine/lualine.nvim"] = {},
	["https://git.sr.ht/~whynothugo/lsp_lines.nvim"] = {
		config = function()
			require("lsp_lines").setup()
		end,
	},
	["weilbith/nvim-code-action-menu"] = {
		cmd = "CodeActionMenu",
	},
	["lewis6991/spellsitter.nvim"] = {
		config = function()
			require("spellsitter").setup({
				-- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
				enable = true,
				debug = false,
			})
		end,
	},
	["gelguy/wilder.nvim"] = {
		config = function()
			local present, wilder = pcall(require, "wilder")
			if not present then
				return
			end
			wilder.setup({ modes = { ":", "/", "?" } })
			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
					-- 'single', 'double', 'rounded' or 'solid'
					-- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
					border = "rounded",
					max_height = "75%", -- max height of the palette
					min_height = 0, -- set to the same as 'max_height' for a fixed height window
					prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
					reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
					left = { " ", wilder.popupmenu_devicons() },
					highlighter = wilder.basic_highlighter(),
				}))
			)
		end,
	},
	["onsails/lspkind.nvim"] = {

		config = function()
			local lspkind = require("lspkind")
			require("cmp").setup({
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, vim_item)
							return vim_item
						end,
					}),
				},
			})
		end,
	},
	-- ["jamestthompson3/nvim-remote-containers"] = {},
	["linty-org/key-menu.nvim"] = {
		config = function()
			vim.keymap.set("n", " ", function()
				require("key-menu").open_window(" ")
			end)

			vim.keymap.set("n", "g", function()
				require("key-menu").open_window("g")
			end)
		end,
	},
	["lvimuser/lsp-inlayhints.nvim"] = {
		config = function()
			require("lsp-inlayhints").setup({
				inlay_hints = {
					parameter_hints = {
						show = true,
						prefix = "<- ",
						separator = ", ",
						remove_colon_start = false,
						remove_colon_end = true,
					},
					type_hints = {
						-- type and other hints
						show = true,
						prefix = "",
						separator = ", ",
						remove_colon_start = false,
						remove_colon_end = false,
					},
					only_current_line = false,
					-- separator between types and parameter hints. Note that type hints are
					-- shown before parameter
					labels_separator = "  ",
					-- whether to align to the length of the longest line in the file
					max_len_align = false,
					-- padding from the left if max_len_align is true
					max_len_align_padding = 1,
					-- highlight group
					highlight = "LspInlayHint",
				},
				enabled_at_startup = true,
				debug_mode = false,
			})
		end,
	},
	["glepnir/galaxyline.nvim"] = {
		branch = "main",
		config = function()
			require("custom.plugins.galaxyline")
		end,
	},
	["lukas-reineke/indent-blankline.nvim"] = {
		override_options = {
			indentLine_enabled = 1,
			filetype_exclude = {
				"help",
				"terminal",
				"alpha",
				"packer",
				"lspinfo",
				"TelescopePrompt",
				"TelescopeResults",
				"mason",
				"",
			},
			buftype_exclude = { "terminal" },
			show_trailing_blankline_indent = false,
			show_first_indent_level = false,
			show_current_context = true,
			show_current_context_start = true,
			char_highlight_list = {
				"IndentBlanklineIndent1",
				"IndentBlanklineIndent2",
				"IndentBlanklineIndent3",
				"IndentBlanklineIndent4",
				"IndentBlanklineIndent5",
				"IndentBlanklineIndent6",
			},
		},
	},
	["b0o/incline.nvim"] = {
		config = function()
			require("custom.plugins.incline")
		end,
	},

	-- ["anuvyklack/windows.nvim"] = {
	-- 	requires = "anuvyklack/middleclass",
	-- 	config = function()
	-- 		require("windows").setup()
	-- 	end,
	-- },
	["kdheepak/lazygit.nvim"] = {},
	["stevearc/aerial.nvim"] = {
		config = function()
			require("custom.plugins.aerial")
		end,
	},
	["tveskag/nvim-blame-line"] = {},
	["akinsho/git-conflict.nvim"] = {
		config = function()
			require("git-conflict").setup({
				default_mappings = true, -- disable buffer local mapping created by this plugin
				disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
				highlights = { -- They must have background color, otherwise the default color will be used
					incoming = "DiffText",
					current = "DiffAdd",
				},
			})
		end,
	},
	["anuvyklack/pretty-fold.nvim"] = {
		config = function()
			require("pretty-fold").setup({
				sections = {
					left = {
						"content",
					},
					right = {
						" ",
						"number_of_folded_lines",
						": ",
						"percentage",
						" ",
						function(config)
							return config.fill_char:rep(3)
						end,
					},
				},
				fill_char = "•",

				remove_fold_markers = true,

				-- Keep the indentation of the content of the fold string.
				keep_indentation = true,

				-- Possible values:
				-- "delete" : Delete all comment signs from the fold string.
				-- "spaces" : Replace all comment signs with equal number of spaces.
				-- false    : Do nothing with comment signs.
				process_comment_signs = "spaces",

				-- Comment signs additional to the value of `&commentstring` option.
				comment_signs = {},

				-- List of patterns that will be removed from content foldtext section.
				stop_words = {
					"@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
				},

				add_close_pattern = true, -- true, 'last_line' or false

				matchup_patterns = {
					{ "{", "}" },
					{ "%(", ")" }, -- % to escape lua pattern char
					{ "%[", "]" }, -- % to escape lua pattern char
				},

				ft_ignore = { "neorg" },
			})
		end,
	},
	["preservim/tagbar"] = {},
	["ray-x/lsp_signature.nvim"] = {},
	["m-demare/hlargs.nvim"] = {
		config = function()
			require("hlargs").setup({})
		end,
	},
	["RRethy/vim-illuminate"] = {
		config = function()
			require("custom.plugins.illuminate")
		end,
	},
	["cljoly/telescope-repo.nvim"] = {},
	["nacro90/numb.nvim"] = {
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
				number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
				centered_peeking = true, -- Peeked line will be centered relative to window
			})
		end,
	},
	["kevinhwang91/nvim-hlslens"] = {
		config = function()
			require("hlslens").setup()
		end,
	},
	["ahmedkhalf/project.nvim"] = {
		config = function()
			require("custom.plugins.project")
		end,
	},
	["lervag/vimtex"] = {},
	["ggandor/lightspeed.nvim"] = {},
	["is0n/jaq-nvim"] = {},
	-- Rails
	["AndrewRadev/splitjoin.vim"] = {},
	["AndrewRadev/tagalong.vim"] = {},
	["AndrewRadev/switch.vim"] = {},
	-- ["vim-ruby/vim-ruby"] = {},

	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},
	-- WebDev
	["MunifTanjim/prettier.nvim"] = {},
	--Debugging
	["mfussenegger/nvim-dap"] = {},
	["rcarriga/nvim-dap-ui"] = {
		config = function()
			require("custom.plugins.dapui")
		end,
	},
	["vuki656/package-info.nvim"] = {
		requires = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("custom.plugins.pinfo")
		end,
	},
	-- ["udalov/kotlin-vim"] = {},
	["jose-elias-alvarez/typescript.nvim"] = {},
	["JoosepAlviste/nvim-ts-context-commentstring"] = {},
	["MaximilianLloyd/ascii.nvim"] = {
		requires = "MunifTanjim/nui.nvim",
	},
	["jbyuki/nabla.nvim"] = {},
	["iamcco/markdown-preview.nvim"] = {
		run = "cd app && yarn install",
		ft = "markdown",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},
	["jackMort/ChatGPT.nvim"] = {
		config = function()
			require("custom.plugins.chatgpt-conf").setup()
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	["frankroeder/parrot.nvim"] = {
		requires = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
		config = function()
			require("parrot").setup({
				-- Providers must be explicitly added to make them available.
				providers = {
					anthropic = {
						api_key = os.getenv("ANTHROPIC_API_KEY"),
					},
					groq = {
						api_key = os.getenv("GROQ_API_KEY"),
					},
					-- provide an empty list to make provider available (no API key required)
					-- ollama = {},
					openai = {
						api_key = os.getenv("OPENAI_API_KEY"),
					},
					-- github = {
					-- 	api_key = os.getenv("GITHUB_TOKEN"),
					-- },
				},
			})
		end,
	},
	-- ["sourcegraph/sg.nvim"] = {
	-- 	run = "nvim -l build/init.lua",
	-- 	config = function()
	-- 		require("sg").setup()
	-- 	end,
	-- },
	["Exafunction/codeium.nvim"] = {
		requires = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("custom.plugins.codeium")
		end,
	},
}
