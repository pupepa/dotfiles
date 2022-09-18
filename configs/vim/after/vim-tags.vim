if !isdirectory(g:plug_home . '/vim-tags')
  finish
endif

let g:vim_tags_auto_generate = 0
let g:vim_tags_use_vim_dispatch = 1

nnoremap <C-]> g<C-]>
