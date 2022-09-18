if !isdirectory(g:plug_home . '/asyncomplete-neosnippet.vim')
  finish
endif

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
    \ 'name': 'snippet',
    \ 'whitelist': ['*'],
    \ 'priority': 1,
    \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
    \ }))
