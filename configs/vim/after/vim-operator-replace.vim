if !isdirectory(g:plug_home . '/vim-operator-replace')
  finish
endif

nmap s <Plug>(operator-replace)
