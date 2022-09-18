if !isdirectory(g:plug_home . '/marks.nvim') || !has('nvim')
  finish
endif

lua <<EOF

require("marks").setup {}

EOF
