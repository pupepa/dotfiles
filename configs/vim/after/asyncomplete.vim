if !isdirectory(g:plug_home . '/asyncomplete.vim')
  finish
endif

" let g:asyncomplete_log_file = expand('~/.vim/tmp/asyncomplete/asyncomplete.log')

inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" See https://github.com/prabirshrestha/asyncomplete.vim/blob/master/autoload/asyncomplete.vim#L452
function! s:sort_by_priority_preprocessor(options, matches) abort
  let l:pair = { '"':  '"',  "''":  "''", }

  let l:items = []
  let l:startcols = []
  for [l:source_name, l:matches] in items(a:matches)
    let l:startcol = l:matches['startcol']
    let l:base = a:options['typed'][l:startcol - 1:]
    for l:item in l:matches['items']
      if stridx(l:item['word'], l:base) == 0
        " Strip pair characters. If pre-typed text is '"', candidates
        " should have '"' suffix.
        if has_key(l:pair, l:base[0])
          let [l:lhs, l:rhs, l:str] = [l:base[0], l:pair[l:base[0]], l:item['word']]
          if len(l:str) > 1 && l:str[0] ==# l:lhs && l:str[-1:] ==# l:rhs
            let l:item['word'] = l:str[:-2]
          endif
        endif
        let l:item['priority'] = get(asyncomplete#get_source_info(l:source_name), 'priority', stridx(l:source_name, 'asyncomplete_lsp') >= 0 ? 100 : 0)
        let l:startcols += [l:startcol]
        call add(l:items, l:item)
      endif
    endfor
  endfor

  let l:items = sort(l:items, {a, b -> b['priority'] - a['priority']})
  let a:options['startcol'] = min(l:startcols)

  call asyncomplete#preprocess_complete(a:options, l:items)
endfunction

" let g:asyncomplete_preprocessor = [function('s:sort_by_priority_preprocessor')]
