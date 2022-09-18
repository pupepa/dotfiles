if !isdirectory(g:plug_home . '/vim-xcode-control')
  finish
endif

nmap <Leader>xb <Plug>(xcode_control_build)
nmap <Leader>xr <Plug>(xcode_control_run)
nmap <Leader>xc <Plug>(xcode_control_clean)
nmap <Leader>xv <Plug>(xcode_control_refresh_canvas)
