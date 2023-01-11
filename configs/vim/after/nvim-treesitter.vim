if !isdirectory(g:plug_home . '/nvim-treesitter') || !has('nvim')
  finish
endif

lua <<EOF

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = { "asciidoc", "vim" }
  },
  matchup = { enable = true }
}

EOF
