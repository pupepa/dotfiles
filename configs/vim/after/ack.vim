if !isdirectory(g:plug_home . '/ack.vim')
  finish
endif

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif
