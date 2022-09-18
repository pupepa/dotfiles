let s:home = has('nvim') ? expand('~/.config/nvim') : expand('~/.vim')
let s:vim_plug_home = s:home . '/vim-plug'

if !isdirectory(s:vim_plug_home)
  finish
endif

nnoremap <silent> <Leader>pu :PlugUpdate<CR>
nnoremap <silent> <Leader>ps :PlugStatus<CR>
nnoremap <silent> <Leader>pd :PlugDiff<CR>
