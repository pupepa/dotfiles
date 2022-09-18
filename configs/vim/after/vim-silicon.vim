if !isdirectory(g:plug_home . '/vim-silicon')
  finish
endif

let g:silicon = {
  \   'theme': 'Solarized (dark)',
  \   'font': 'HackGenNerd',
  \   'background': '#97A1AC',
  \   'shadow-color': '#555555',
  \   'line-number': v:false,
  \   'round-corner': v:true,
  \   'window-controls': v:true,
  \   'output': '~/Downloads/silicon-{time:%Y-%m-%d-%H%M%S}.png',
\ }
