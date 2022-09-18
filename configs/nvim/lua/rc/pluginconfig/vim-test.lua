vim.cmd([[
let g:test#strategy = 'dispatch'

nnoremap <Leader>tf :<C-u>TestFile<CR>
nnoremap <Leader>ts :<C-u>TestSuite<CR>
nnoremap <Leader>tl :<C-u>TestLast<CR>
]])
