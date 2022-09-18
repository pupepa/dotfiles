if !isdirectory(g:plug_home . '/fzf.vim')
  finish
endif

let g:fzf_command_prefix = 'Fzf'

command! -bang -nargs=* FzfRg
  \ call fzf#vim#grep(
  \ 'rg --column --line-number --hidden --ignore-case --no-heading --glob "!.git/*" '.shellescape(<q-args>), 1,
  \ <bang>0 ? fzf#vim#with_preview({'options': '--reverse --delimiter : --nth 4..'}, 'up:60%')
  \ : fzf#vim#with_preview({'options': '--reverse --delimiter : --nth 4..'}, 'right:50%'),
  \ <bang>0)

command! -bang -nargs=? -complete=dir FzfFiles
  \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always --style=plain --theme="Solarized (dark)" {}']}, <bang>0)

command! -bang -nargs=? -complete=dir FzfHistory
  \ call fzf#vim#history(fzf#vim#with_preview({ "placeholder": "{1}" }))

command! -bang -nargs=? -complete=dir FzfLines
  \ call fzf#vim#lines({'options': ['--layout=reverse', '--info=inline']})

command! -bang -nargs=? -complete=dir FzfBuffers
  \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({ "placeholder": "{1}" }), <bang>0)

command! -bang -nargs=? -complete=dir FzfCommands
  \ call fzf#vim#commands({'options': ['--layout=reverse', '--info=inline']})

command! -bang -nargs=? -complete=dir FzfGitFiles
  \ call fzf#vim#gitfiles(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always --style=plain --theme="Solarized (dark)" {}']}, <bang>0)

command! -bang -nargs=? -complete=dir FzfMemoList
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>).' '.g:memolist_path, 1,
  \   fzf#vim#with_preview(), <bang>0)

command! FzfLcd
  \ call fzf#run(fzf#wrap(
  \   'fzflcd',
  \   {'source': 'find '.getcwd().' -type d -not -name ".*" -maxdepth 5 | grep -v "Operation not permitted"', 'sink': 'lcd'},
  \   <bang>0))

command! FzfGhq call fzf#run({
      \ 'down': '40%',
      \ 'source': 'ghq list -p',
      \ 'sink': 'lcd'})

" バッファを削除する {{{1
" https://github.com/junegunn/fzf.vim/pull/733#issuecomment-559720813
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! FzfBDelete call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

nnoremap <silent> <Space>B :<C-u>FzfBDelete<CR>
" }}}1

nnoremap <silent> <C-p>    :<C-u>FzfFiles<CR>
nnoremap <silent> <Space>b :<C-u>FzfBuffers<CR>
nnoremap <silent> <Space>f :<C-u>FzfRg<CR>
nnoremap <silent> <Space>g :<C-u>FzfGitFiles<CR>
nnoremap <silent> <Space>r :<C-u>FzfHistory<CR>
nnoremap <silent> <Space>c :<C-u>FzfCommands<CR>
nnoremap <silent> <Space>l :<C-u>FzfBLines<CR>
nnoremap <silent><expr> <Space>L ":<C-u>call fzf#vim#lines(expand('<cword>'), {'options': ['--layout=reverse', '--info=inline']})<CR>"
nnoremap <silent> <Space>d :FzfLcd<CR>
nnoremap <silent> <Space>] :<C-u>FzfGhq<CR>
nnoremap <Leader>mg :<C-u>FzfMemoList 
nnoremap <silent> <Space>t :<C-u>FzfFiles ~/.vimtmp<CR>
