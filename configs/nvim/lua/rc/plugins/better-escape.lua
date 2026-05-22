return {
  -- Escape from insert mode without delay when typing
  -- https://github.com/max397574/better-escape.nvim
  {
    "max397574/better-escape.nvim",
    keys = { { "jj", mode = "i" } },
    opts = {
      timeout = vim.o.timeoutlen,
      default_mappings = false,
      mappings = {
        i = {
          j = {
            j = "<Esc>",
            k = "<Esc>",
          },
        },
      },
    },
  },
}
