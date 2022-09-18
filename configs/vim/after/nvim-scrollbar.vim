if !isdirectory(g:plug_home . '/nvim-scrollbar.nvim') || !has('nvim')
  finish
endif

lua <<EOF

require("scrollbar").setup()

EOF
