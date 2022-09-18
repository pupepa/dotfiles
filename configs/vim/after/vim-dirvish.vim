if !isdirectory(g:plug_home . '/vim-dirvish')
  finish
endif

nnoremap <silent> <C-n> :<C-u>Dirvish<CR>
let g:dirvish_mode = ':sort i ,^.*[\/],'
" let g:dirvish_mode = ':sort i ,^.*[\/],'

let g:loaded_netrwPlugin = 1

command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

augroup vimrc_dirvish
  autocmd!
  autocmd FileType dirvish nmap <silent><buffer> <C-n> <Plug>(dirvish_quit)

  autocmd FileType dirvish nnoremap <buffer><silent>l :<C-u>.call dirvish#open('edit', 0)<CR>
  autocmd FileType dirvish nmap <silent><buffer> h <Plug>(dirvish_up)
  autocmd FileType dirvish xmap <silent><buffer> h <Plug>(dirvish_up)

  autocmd FileType dirvish nnoremap <silent><buffer> ~ :Dirvish ~/<CR>

  autocmd FileType dirvish nnoremap <silent><buffer> dd :Shdo rm -rf {}<CR>
  autocmd FileType dirvish vnoremap <silent><buffer> d :Shdo rm -rf {}<CR>
  autocmd FileType dirvish nnoremap <silent><buffer> rr :Shdo mv {}<CR>
  autocmd FileType dirvish vnoremap <silent><buffer> r :Shdo mv {}<CR>
  autocmd FileType dirvish nnoremap <silent><buffer> cc :Shdo cp {}<CR>
  autocmd FileType dirvish vnoremap <silent><buffer> c :Shdo cp {}<CR>
augroup END
