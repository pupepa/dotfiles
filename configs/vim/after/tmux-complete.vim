if !isdirectory(g:plug_home . '/tmux-complete.vim')
  finish
endif

let g:tmuxcomplete#capture_args = ''
let g:tmuxcomplete#asyncomplete_source_options = {
    \ 'name':      'tmuxcomplete',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['text', 'markdown', 'asciidoc', 'swift', 'ruby'],
    \ 'priority': 2,
    \ 'config': {
    \     'splitmode':      'words',
    \     'filter_prefix':   1,
    \     'show_incomplete': 1,
    \     'sort_candidates': 0,
    \     'scrollback':      0,
    \     'truncate':        0
    \     }
    \ }
