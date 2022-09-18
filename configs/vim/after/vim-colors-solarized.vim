if !isdirectory(g:plug_home . '/vim-colors-solarized')
  finish
endif

if !has("gui_running")
  let g:solarized_dark_patched = 1
end

set background=dark
colorscheme solarized
