if !isdirectory(g:plug_home . '/lightline-bufferline')
  finish
endif

let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#number_separator = ': '
