vim.g.BufKillCreateMappings = 0

vim.cmd([[
nnoremap <silent> <Leader>bd :<C-u>BW<CR>
nnoremap <silent> <Leader>bdd :<C-u>BW!<CR>
]])
