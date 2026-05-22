return {
  -- Bundle of two dozen new text objects for Neovim.
  -- https://github.com/chrisgrieser/nvim-various-textobjs
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    keys = {
      {
        "ae",
        "<Cmd>lua require('various-textobjs').entireBuffer()<CR>",
        mode = { "o", "x" },
        desc = "entire buffer",
      },
      {
        "ib",
        "<Cmd>lua require('various-textobjs').anyQuote('inner')<CR>",
        mode = { "o", "x" },
        desc = "inner any quote",
      },
      {
        "ab",
        "<Cmd>lua require('various-textobjs').anyQuote('outer')<CR>",
        mode = { "o", "x" },
        desc = "a any quote",
      },
      {
        "iu",
        '<cmd>lua require("various-textobjs").url()<CR>',
        mode = { "o", "x" },
        desc = "inner url",
      },
      {
        "il",
        '<cmd>lua require("various-textobjs").lineCharacterwise()<CR>',
        mode = { "o", "x" },
        desc = "inner line characterwise",
      },
    },
    opts = {
      useDefaults = false,
    },
  },
}
