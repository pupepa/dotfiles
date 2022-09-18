if !isdirectory(g:plug_home . '/asyncomplete-look.vim')
  finish
endif

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#look#get_source_options({
  \ 'name': 'look',
  \ 'whitelist': ['*'],
  \ 'blacklist': ['ruby', 'swift'],
  \ 'completor': function('asyncomplete#sources#look#completor'),
  \ 'priority': 1,
  \ 'config': {
  \   'complete_min_chars': 2,
  \   'allow_first_capital_letter': 1,
  \ },
  \ }))
