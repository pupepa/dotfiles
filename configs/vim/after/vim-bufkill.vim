if !isdirectory(g:plug_home . '/vim-bufkill')
  finish
endif

let g:BufKillCreateMappings = 0

nnoremap <silent> <Leader>bd :<C-u>BD<CR>
nnoremap <silent> <Leader>bdd :<C-u>BD!<CR>
