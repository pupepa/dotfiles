if !isdirectory(g:plug_home . '/vim-tmux-navigatior')
  finish
endif

tnoremap <C-j> <c-\><c-n>:TmuxNavigateDown<CR>
tnoremap <C-k> <c-\><c-n>:TmuxNavigateUp<CR>
tnoremap <C-l> <c-\><c-n>:TmuxNavigateRight<CR>
tnoremap <C-h> <c-\><c-n>:TmuxNavigateLeft<CR>
