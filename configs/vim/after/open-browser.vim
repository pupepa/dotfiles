if !isdirectory(g:plug_home . '/open-browser.vim')
  finish
endif

let g:netrw_nogx = 1 " disable netrw's gx mapping.

nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
