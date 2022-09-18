vim.cmd([[
" Ruby
call altr#define('lib/*/%/%.rb', 'spec/%/%_spec.rb')
call altr#define('%/%/%/%.swift', '%Tests/%/%/%Tests.swift')

" Swift
call altr#define('%View.swift', '%ViewModel.swift')

nmap <leader>a <Plug>(altr-forward)
]])
