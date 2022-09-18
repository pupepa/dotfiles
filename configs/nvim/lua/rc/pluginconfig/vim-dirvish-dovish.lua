vim.cmd([[
  let g:dirvish_dovish_map_keys = 0
  augroup dirvish_config
  autocmd!
  " unmap dirvish default
  autocmd FileType dirvish silent! unmap <buffer><C-p>
  autocmd FileType dirvish silent! unmap <buffer>p
  " My mappings
  autocmd FileType dirvish silent! map <buffer>i <Plug>(dovish_create_file)
  autocmd FileType dirvish silent! map <buffer>I <Plug>(dovish_create_directory)
  autocmd FileType dirvish silent! map <buffer>dd <Plug>(dovish_delete)
  autocmd FileType dirvish silent! map <buffer>r <Plug>(dovish_rename)
  autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)
  autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)
  autocmd FileType dirvish silent! map <buffer>p <Plug>(dovish_copy)
  autocmd FileType dirvish silent! map <buffer>P <Plug>(dovish_move)
  augroup END
]])
