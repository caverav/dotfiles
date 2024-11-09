vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

 local function save_fold_state()
   local buf = vim.api.nvim_get_current_buf()
   local folded_lines = {}
   for lnum in ipairs(vim.api.nvim_buf_line_count(buf)) do
     if vim.fn.foldlevel(lnum) > 0 then
       table.insert(folded_lines, { lnum, vim.fn.foldclosedend(lnum) })
     end
   end
   vim.fn.setreg('z', folded_lines)
 end

 -- Function to restore fold state
 local function restore_fold_state()
   local buf = vim.api.nvim_get_current_buf()
   if not vim.fn.reg_executablen('z') then return end
   local folded_lines = vim.fn.getreg('z', 1, true)
   for _, fold in ipairs(folded_lines) do
     local lnum = fold[1]
     local end_lnum = fold[2]
     if end_lnum == -1 then end_lnum = nil end
     vim.fn.foldclosed(lnum, end_lnum)
   end
 end
