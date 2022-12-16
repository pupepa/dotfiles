vim.keymap.set("n", "<C-p>", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Space>r", "<Cmd>FzfLua oldfiles<CR>")
vim.keymap.set("n", "<Space>b", "<Cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<Space>c", "<Cmd>FzfLua commands<CR>")
vim.keymap.set("n", "<Space>l", "<Cmd>FzfLua blines<CR>")
vim.keymap.set("n", "<Space>f", "<Cmd>FzfLua grep<CR>")
vim.keymap.set("n", "<Space>F", "<Cmd>FzfLua grep_last<CR>")
vim.keymap.set("n", "<Space><Space>", "<Cmd>FzfLua resume<CR>")
vim.keymap.set(
  "n",
  "<Space>]",
  "<Cmd>lua require'fzf-lua'.files({ prompt='GHQ> ', cmd = 'ghq list', cwd='~/ghq' })<CR>"
)
vim.keymap.set("n", "<Space>w", "<Cmd>FzfLua grep_cword<CR>")
-- nnoremap <silent> <Space>f :<C-u>FzfRg<CR>
-- nnoremap <silent> <Space>g :<C-u>FzfGitFiles<CR>
-- nnoremap <silent><expr> <Space>L ":<C-u>call fzf#vim#lines(expand('<cword>'), {'options': ['--layout=reverse', '--info=inline']})<CR>"
-- nnoremap <silent> <Space>d :FzfLcd<CR>
-- nnoremap <silent> <Space>] :<C-u>FzfGhq<CR>
-- nnoremap <Leader>mg :<C-u>FzfMemoList
-- nnoremap <silent> <Space>t :<C-u>FzfFiles ~/.vimtmp<CR>
