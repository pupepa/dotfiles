if !isdirectory(g:plug_home . '/vim-precious')
  finish
endif

let g:precious_enable_switchers = {
\   "vim-plug" : {
\     "setfiletype": 0
\   }
\ }

let g:context_filetype#search_offset = 300
