if !isdirectory(g:plug_home . '/nvim-ts-autotag') || !has('nvim')
  finish
endif

lua <<EOF

require('nvim-ts-autotag').setup()

EOF
