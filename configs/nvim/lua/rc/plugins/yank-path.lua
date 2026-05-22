return {
  -- A minimal neovim plugin to help copying the file path (in various formats) to the clipboard.
  -- https://github.com/ywpkwon/yank-path.nvim
  {
    "ywpkwon/yank-path.nvim",
    dependencies = { "stevearc/oil.nvim" },
    keys = {
      {
        "<Leader>yp",
        ":YankPath<CR>",
        desc = "Yank Path",
        silent = true,
      },
      {
        "<Leader>yc",
        ":YankPathCwd<CR>",
        desc = "Yank Path from Cwd",
        silent = true,
      },
    },
    opts = {
      default_mapping = false,
      use_oil = true,
    },
  },
}
