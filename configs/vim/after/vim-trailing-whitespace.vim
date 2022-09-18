if !isdirectory(g:plug_home . '/vim-trailing-whitespace')
  finish
endif

nnoremap <silent><Leader>tr :FixWhitespace<CR>
