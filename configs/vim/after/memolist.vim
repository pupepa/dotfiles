if !isdirectory(g:plug_home . '/memolist.vim')
  finish
endif

let g:memolist_path = "$HOME/Documents/memolist"
let g:memolist_memo_suffix = "md"
let g:memolist_denite = 0

nnoremap <Leader>mn :MemoNew<CR>
nnoremap <Leader>ml :<C-u>call fzf#vim#files(g:memolist_path, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always --style=plain --theme="Solarized (dark)" {}']})<CR>
