return {
  -- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-comment.md
  {
    "nvim-mini/mini.comment",
    version = "*",
    opts = {
      custom_commentstring = function()
        return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
      end,
    },
  },
}
