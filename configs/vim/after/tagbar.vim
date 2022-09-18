if !isdirectory(g:plug_home . '/tagbar')
  finish
endif

nnoremap <silent><leader>tg :TagbarToggle<CR>
