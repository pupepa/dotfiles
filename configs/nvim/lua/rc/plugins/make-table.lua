return {
  {
    "pupepa/make-table.nvim",
    -- dir = "~/.config/nvim/lua/modules/make-table",
    cmd = { "MakeTable", "UnmakeTable", "RemakeTable" },
    ---@type makeTable.Config
    opts = { first_row_as_header = true },
  },
}
