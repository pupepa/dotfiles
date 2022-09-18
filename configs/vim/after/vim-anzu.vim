if !isdirectory(g:plug_home . '/vim-anzu')
  finish
endif

" mapping
nmap n <Plug>(anzu-n)zz
nmap N <Plug>(anzu-N)zz
nmap * <Plug>(anzu-star)zz
nmap # <Plug>(anzu-sharp)zz

" clear status
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>:<C-u>AnzuClearSearchStatus<CR>
