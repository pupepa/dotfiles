if !isdirectory(g:plug_home . '/vim-operator-convert-case')
  finish
endif

nmap cc <Plug>(operator-convert-case-loop)
xmap cc <Plug>(operator-convert-case-loop)
