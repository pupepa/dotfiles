if !isdirectory(g:plug_home . '/vim-sandwich')
  finish
endif

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
  \ {
  \   'buns':     ['${', '}'],
  \   'input':    ['$'],
  \   'filetype': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
  \ },
  \ {
  \   'buns':     ['#{', '}'],
  \   'input':    ['#'],
  \   'filetype': ['ruby', 'eruby'],
  \ },
  \ {
  \   'buns'    : ['「', '」'],
  \   'input'   : ['c'],
  \ },
  \ {
  \   'buns':     ['[[', ']]'],
  \   'input':    ['l'],
  \   'filetype': ['markdown'],
  \ },
  \ ]
