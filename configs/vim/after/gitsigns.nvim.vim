if !isdirectory(g:plug_home . '/gitsigns.nvim')
  finish
endif

lua <<EOF

require('gitsigns').setup()

EOF
