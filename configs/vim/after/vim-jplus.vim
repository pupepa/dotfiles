if !isdirectory(g:plug_home . '/vim-jplus')
  finish
endif

" J の挙動を jplus.vim で行う
nmap J <Plug>(jplus)
vmap J <Plug>(jplus)

" getchar() を使用して挿入文字を入力
nmap <Leader>J <Plug>(jplus-getchar)
vmap <Leader>J <Plug>(jplus-getchar)

let g:jplus#input_config = {
\  "__DEFAULT__" : {
\    "delimiter_format" : " %d "
\  },
\  "__EMPTY__" : {
\    "delimiter_format" : "%d"
\  },
\  "," : {
\    "delimiter_format" : "%d "
\  }
\}
