return {
  -- Vim syntax for Re:VIEW
  -- https://github.com/tokorom/vim-review
  {
    "tokorom/vim-review",
    ft = "review",
    init = function()
      vim.g["vim_review#include_filetypes"] = { "swift", "ruby", "json", "yaml" }
    end,
  },
}
