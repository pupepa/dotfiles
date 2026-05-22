return {
  -- Extensible Neovim Scrollbar
  -- https://github.com/petertriho/nvim-scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
      local colors = require("tokyonight.colors").setup()
      require("scrollbar").setup({
        handle = {
          color = colors.fg,
        },
      })
    end,
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
      "folke/tokyonight.nvim",
    },
  },
}
