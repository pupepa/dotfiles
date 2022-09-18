if !isdirectory(g:plug_home . '/asyncomplete-buffer.vim')
  finish
endif

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['text', 'markdown', 'asciidoc'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'priority': 5,
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))
