require("nvim-treesitter.configs").setup({
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { "asciidoc", "vim" },
  },
})
