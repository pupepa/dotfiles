if !isdirectory(g:plug_home . '/vim-easy-motion')
  finish
endif

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_use_migemo = 1

nmap <Leader>s <Plug>(easymotion-s2)
