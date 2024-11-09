 local M = {}

 function M.setup()
   vim.cmd([[
   augroup FoldPersistence
     autocmd!
     " Save folds when entering insert mode
     autocmd InsertEnter * let b:saved_fdm = &foldmethod | setlocal foldmethod=manual
     " Restore folds when leaving insert mode
     autocmd InsertLeave * if exists('b:saved_fdm') | setlocal foldmethod=b:saved_fdm | unlet b:saved_fdm | endif
   augroup END
   ]])
 end

 return M

