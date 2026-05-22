return {
  -- nippet plugin for Neovim
  -- https://github.com/dcampos/nvim-snippy
  {
    "dcampos/nvim-snippy",
    lazy = true,
    opts = { snippet_dirs = { "~/.config/nvim/snippets", "~/.config/nvim/snippets_private" } },
  },
}
