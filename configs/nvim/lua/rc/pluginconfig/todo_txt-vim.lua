vim.cmd([[
" Use todo#Complete as the omni complete function for todo files
au filetype todo setlocal omnifunc=todo#Complete

" Auto complete projects
" au filetype todo imap <buffer> + +<C-X><C-O>

" Auto complete contexts
" au filetype todo imap <buffer> @ @<C-X><C-O>

au filetype todo setlocal completeopt-=preview

let g:Todo_txt_do_not_map = 1
]])
