return {
  -- https://github.com/delphinus/cellwidths.nvim
  {
    "delphinus/cellwidths.nvim",
    event = "VeryLazy",
    config = function()
      require("cellwidths").setup({
        name = "cica",
      })
    end,
  },
}
