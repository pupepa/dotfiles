vim.g.memolist_path = "$HOME/Documents/memolist"
vim.g.memolist_memo_suffix = "md"
vim.g.memolist_denite = 0

vim.keymap.set('n', '<Leader>mn', ':MemoNew<CR>')
-- nnoremap <Leader>ml :<C-u>call fzf#vim#files(g:memolist_path, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always --style=plain --theme="Solarized (dark)" {}']})<CR>
