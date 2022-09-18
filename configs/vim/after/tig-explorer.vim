if !isdirectory(g:plug_home . '/tig-explorer.vim')
  finish
endif

nnoremap <Leader>tt :<C-u>Tig<CR>
