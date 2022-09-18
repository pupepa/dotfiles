if !isdirectory(g:plug_home . '/vim-speeddating')
  finish
endif

autocmd VimEnter * 1 SpeedDatingFormat %-m/%-d
autocmd VimEnter * 2 SpeedDatingFormat %Y/%m/%d
