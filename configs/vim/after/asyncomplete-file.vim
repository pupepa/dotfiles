if !isdirectory(g:plug_home . '/asyncomplete-file.vim')
  finish
endif

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['unite'],
    \ 'priority': 8,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
