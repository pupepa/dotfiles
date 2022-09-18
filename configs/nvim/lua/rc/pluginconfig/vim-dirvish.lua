vim.keymap.set("n", "<C-n>", ":Dirvish<CR>", { silent = true })
vim.g.dirvish_mode = ':sort i ,^.*[\\/],'
vim.g.loaded_netrwPlugin = 1

vim.cmd([[
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
]])
