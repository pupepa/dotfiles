if !isdirectory(g:plug_home . '/neosnippet.vim')
  finish
endif

let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
let g:neosnippet#snippets_directory = [$HOME . '/.vim/snippets', $HOME . '/.vim/snippets_private']

" imap <Tab> <Plug>(neosnippet_expand_or_jump)
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
