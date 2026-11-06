return {
  -- Extensible Neovim Scrollbar
  -- https://github.com/petertriho/nvim-scrollbar
  {
    "petertriho/nvim-scrollbar",
    branch = "v1",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      local colors = require("houston.palette")
      require("scrollbar").setup({
        handle = {
          color = colors.fg_dim,
        },
      })
    end,
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
      "devbydaniel/houston.nvim",
    },
  },
}
