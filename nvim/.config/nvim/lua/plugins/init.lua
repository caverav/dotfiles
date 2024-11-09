return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require("conform").setup(require "configs.conform")
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  -- Core dependencies
  { "nvim-lua/plenary.nvim", lazy = true },

  { "lewis6991/impatient.nvim" },

  {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Completion and snippets
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        config = function()
          require("copilot").setup {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
              ["*"] = true,
            },
            copilot_node_command = "node", -- Node.js version must be > 18.x
            server_opts_overrides = {},
          }
        end,
      },
      {
        "zbirenbaum/copilot-cmp",
        after = "copilot.lua",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  },
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
  { "saadparwaiz1/cmp_luasnip", lazy = true },

  -- Miscellaneous plugins
  {
    "windwp/nvim-autopairs",
    lazy = true,
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  },

  {
    "goolord/alpha-nvim",
    lazy = false,
    disable = true,
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("plugins.configs.others").comment()
    end,
  },

  -- File management and pickers
  {
    "kyazdani42/nvim-tree.lua",
    lazy = true,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.configs.nvimtree"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    config = function()
      require "plugins.configs.telescope"
    end,
  },

  -- Key bindings
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`" },
    config = function()
      require "plugins.configs.whichkey"
    end,
    disable = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
  {
    "yetone/avante.nvim",
    lazy = false,
    build = "make",
    config = function()
      require "plugins.configs.avante"
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "zbirenbaum/copilot.lua",
    },
  },

  -- {
  --     "zbirenbaum/copilot.lua",
  --     cmd = "Copilot",
  --     event = "InsertEnter",
  --     build = ":Copilot auth",
  --     module = "copilot",
  --     config = function()
  --         require('copilot').setup({
  --             suggestion = { enabled = false },
  --             panel = { enabled = false },
  --             filetypes = {
  --                 ["*"] = true,
  --             },
  --             copilot_node_command = 'node', -- Node.js version must be > 18.x
  --             server_opts_overrides = {},
  --             plugin_manager_path = vim.fn.stdpath("data") .. "/mason",
  --         })
  --     end,
  -- },
  -- {
  --     "zbirenbaum/copilot-cmp",
  --     dependencies = { "copilot.lua" },
  --     after = { "copilot.lua" },
  --     event = { "InsertEnter", "LspAttach" },
  --     fix_pairs = true,
  --     config = function()
  --       require("copilot_cmp").setup()
  --     end,
  -- },

  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup {}
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact" },
    config = function()
      local present, autotag = pcall(require, "nvim-ts-autotag")
      if present then
        autotag.setup()
      end
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    config = function()
      require "plugins.configs.null-ls"
    end,
  },

  {
    "Pocco81/TrueZen.nvim",
    cmd = { "TZAtaraxis", "TZMinimalist", "TZFocus" },
    config = function()
      require "plugins.configs.truezen"
    end,
  },

  {
    "nvim-treesitter/playground",
    cmd = "TSCaptureUnderCursor",
    config = function()
      require("nvim-treesitter.configs").setup()
    end,
  },

  {
    "andreadev-it/shade.nvim",
    lazy = true,
    config = function()
      require "plugins.configs.shade"
    end,
  },

  {
    "Pocco81/AutoSave.nvim",
    lazy = true,
    config = function()
      require("autosave").setup()
    end,
  },

  {
    "nvim-neorg/neorg",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    config = function()
      require("plugins.configs.neorg").setup()
    end,
    build = ":Neorg sync-parsers",
  },

  {
    "jbyuki/venn.nvim",
    lazy = true,
    config = function()
      require("plugins.configs.venn").setup()
    end,
  },

  {
    "rmagatti/goto-preview",
    lazy = true,
    config = function()
      require("goto-preview").setup {
        border = "rounded",
        default_mappings = true,
      }
    end,
  },

  {
    "tpope/vim-surround",
    lazy = true,
  },

  {
    "mattn/emmet-vim",
    lazy = true,
  },

  {
    "terryma/vim-multiple-cursors",
    lazy = true,
  },

  {
    "folke/trouble.nvim",
    lazy = true,
    config = function()
      require "plugins.configs.trouble"
    end,
  },

  {
    "folke/todo-comments.nvim",
    lazy = true,
    config = function()
      require "plugins.configs.todo-comments"
    end,
  },

  {
    "tpope/vim-fugitive",
    lazy = true,
  },

  {
    "junegunn/gv.vim",
    lazy = true,
  },

  {
    "rcarriga/nvim-notify",
    lazy = true,
    config = function()
      require "plugins.configs.notify"
    end,
  },

  {
    "andweeb/presence.nvim",
    lazy = true,
    config = function()
      require "plugins.configs.presence"
    end,
  },

  {
    "phaazon/hop.nvim",
    lazy = true,
    config = function()
      require("hop").setup {}
    end,
  },

  {
    "folke/twilight.nvim",
    lazy = true,
    config = function()
      require "plugins.configs.twilight"
    end,
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require "plugins.configs.navic"
    end,
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    config = function()
      require "plugins.configs.dressing"
    end,
  },

  {
    "romgrk/barbar.nvim",
    lazy = true,
  },

  {
    "xiyaowong/nvim-transparent",
    lazy = true,
    config = function()
      require "plugins.configs.transparent"
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "evince"
    end,
  },
  {
    "pwntester/octo.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR 'ibhagwan/fzf-lua',
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
  },
  {
    "supermaven-inc/supermaven-nvim",
    lazy = false,
    config = function()
      require("supermaven-nvim").setup {}
    end,
  },
  {
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init {
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      }
    end,
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
    end,
  },
  {
    "edluffy/hologram.nvim",
    config = function()
      require("hologram").setup {
        auto_disable = true,
      }
    end,
  },
  {
    "anuvyklack/fold-preview.nvim",
    requires = "anuvyklack/keymap-amend.nvim",
    config = function()
      require("fold-preview").setup {
        -- Your configuration goes here.
      }
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
    },
    lazy = false,
    config = function()
      require "plugins.configs.codecompanion"
    end,
  },
  -- {
  --   "MunifTanjim/eslint.nvim",
  --   lazy = true,
  --   config = function()
  --     require("eslint").setup()
  --   end
  --   }
}
