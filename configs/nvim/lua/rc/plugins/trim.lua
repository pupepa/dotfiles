return {
  -- This plugin trims trailing whitespace and lines.
  -- https://github.com/cappyzawa/trim.nvim
  {
    "cappyzawa/trim.nvim",
    cmd = { "TrimToggle", "Trim" },
    keys = {
      {
        "<Leader>tr",
        "<Cmd>Trim<CR>",
        desc = "Trim whitespace",
      },
    },
    opts = {
      trim_last_line = false,
      trim_first_line = false,
    },
  },
}
