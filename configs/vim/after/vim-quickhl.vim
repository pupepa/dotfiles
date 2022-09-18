if !isdirectory(g:plug_home . '/vim-quickhl')
  finish
endif

nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-toggle)
xmap <Space>M <Plug>(quickhl-manual-toggle)
