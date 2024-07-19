
" ------------------------------------------------------------
" Autocommand 03:
" Templates

augroup nvim_templates
  au!
  " read in templates files
  autocmd bufnewfile *.* silent! execute '0r ' . stdpath("config")  . "\\templates\\" . expand("%:e") . ".tpl"
augroup end

" :h :e[dit]

" usage:
" :e example1.py
" press enter

" -->
" #!/usr/bin/env python3

" ------------------------------------------------------------
" Autocommand 04:
" Show cursor line only in active window

" https://github.com/folke/dot/tree/master/config/nvim
" https://github.com/tjdevries/config_manager
augroup nvim_cursorline
  au!
  autocmd insertleave,winenter * set cursorline
  autocmd insertenter,winleave * set nocursorline
augroup end

" ------------------------------------------------------------
" Autocommand 05:
" Terminal

augroup nvim_terminal
    au!
    " au filetype markdown,rst,text,mail execute source stdpath("config") . "\\" . "prose.vim"
    au termopen * setlocal nonumber norelativenumber signcolumn=no
augroup end

" ------------------------------------------------------------
" Autocommand 06:


" ------------------------------------------------------------

