if !isdirectory(g:plug_home . '/vim-easy-align')
  finish
endif

xmap gA <Plug>(EasyAlign)
nmap gA <Plug>(EasyAlign)

