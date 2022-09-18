if !isdirectory(g:plug_home . '/neogen') || !has('nvim')
  finish
endif

lua <<EOF

require('neogen').setup {}

EOF
