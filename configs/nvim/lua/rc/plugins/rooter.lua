return {
  -- cd project root automatically
  -- https://github.com/wsdjeg/rooter.nvim
  {
    "wsdjeg/rooter.nvim",
    opts = {
      root_patterns = { "Gemfile", ".git/" },
      outermost = false,
    },
    dependencies = {
      {
        "wsdjeg/logger.nvim",
        config = function()
          vim.keymap.set("n", "<leader>hL", '<cmd>lua require("logger").viewRuntimeLog()<cr>', { silent = true })
        end,
      },
    },
  },
}
