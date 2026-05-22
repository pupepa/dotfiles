return {
  -- Highlight arguments' definitions and usages, using Treesitter
  -- https://github.com/m-demare/hlargs.nvim
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    config = function()
      require("hlargs").setup()
    end,
  },
}
