if !isdirectory(g:plug_home . '/vim-quickrun')
  finish
endif

let g:quickrun_config = {
      \ '_' : {
      \   'runner': 'system'
      \   }
      \ }
let g:quickrun_config.markdown = {
      \ 'outputter' : 'null',
      \ 'command' : 'open',
      \ 'cmdopt' : '-a',
      \ 'args' : '/Applications/Google\ Chrome.app',
      \ 'exec' : '%c %o %a %s'
      \ }
let g:quickrun_config['ruby.bundle'] = {
      \ 'command' : 'ruby',
      \ 'cmdopt' : 'bundle exec',
      \ 'exec' : '%o %c %s'
      \ }

let g:quickrun_config['markdown.marp'] = {
      \ 'command' : 'marp',
      \ 'cmdopt' : '--theme-set ./marp-themes/test.css -p',
      \ 'runner' : 'terminal',
      \ 'exec' : '%c %o %s'
      \ }
