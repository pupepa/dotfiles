return {
  -- https://github.com/delphinus/cellwidths.nvim
  {
    "delphinus/cellwidths.nvim",
    event = "VeryLazy",
    config = function()
      require("cellwidths").setup({
        name = "cica"
        -- name = "user/custom",
        -- ---@param cw cellwidths
        -- fallback = function(cw)
        --   cw.add {
        --     { 0x2160, 0x2169, 2 },
        --     { 0x2460, 0x2469, 2 }
        --   }
        -- end,
      })
    end,
  },
}
