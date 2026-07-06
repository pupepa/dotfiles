return {
  -- Neovim plugin introducing a new operators motions to quickly replace and exchange text.
  -- https://github.com/gbprod/substitute.nvim
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    config = function()
      require("substitute").setup()

      -- keysで定義するとエラーが発生するため、ここで設定する
      vim.keymap.set("n", "gs", require("substitute").operator, { noremap = true })
      vim.keymap.set("n", "gS", require("substitute").eol, { noremap = true })
      vim.keymap.set("x", "gs", require("substitute").visual, { noremap = true })
    end,
  },
}
