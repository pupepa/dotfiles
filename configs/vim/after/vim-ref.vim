if !isdirectory(g:plug_home . '/vim-ref')
  finish
endif

let g:ref_refe_encoding = 'utf-8'

let g:ref_source_webdict_sites = {
  \ 'weblio_ruigo': {
  \   'url': 'http://thesaurus.weblio.jp/content/%s',
  \   'keyword_encoding': 'utf-8',
  \   'cache': 1,
  \   },
  \ 'weblio_en': {
  \   'url': 'https://ejje.weblio.jp/content/%s',
  \   'keyword_encoding': 'utf-8',
  \   'cache': 0,
  \   },
  \ }

function! g:ref_source_webdict_sites.weblio_ruigo.filter(output)
  return join(split(a:output, "\n")[41 :], "\n")
endfunction

function! g:ref_source_webdict_sites.weblio_en.filter(output)
  return join(split(a:output, "\n")[25 :], "\n")
endfunction

let g:ref_source_webdict_sites.default = 'weblio_en'

nnoremap <silent> <Leader>wb :Ref webdict weblio_ruigo <C-r>=expand('<cword>')<CR><CR>
nnoremap <silent> <Leader>en :<C-u>call ref#jump('normal', 'webdict')<CR>
vnoremap <silent> <Leader>en :<C-u>call ref#jump('visual', 'webdict')<CR>

command! -nargs=1 Ruigo Ref webdict weblio_ruigo <args>
command! -nargs=1 Refe Ref refe <args>
