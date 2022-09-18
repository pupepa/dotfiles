if !isdirectory(g:plug_home . '/vim-lsp-settings')
  finish
endif

let g:lsp_settings_servers_dir = expand('~/.cache/vim/servers')

let g:lsp_settings_filetype_ruby = ['steep', 'typeprof', 'solargraph']
" augroup ruby_lsp_settings
"   autocmd FileType ruby if executable('steep') | let g:lsp_settings_filetype_ruby = ['steep'] | else | let g:lsp_settings_filetype_ruby = ['solargraph'] | endif
" augroup end
