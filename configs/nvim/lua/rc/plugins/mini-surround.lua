return {
  -- Neovim Lua plugin with fast and feature-rich surround actions. Part of 'mini.nvim' library.
  -- https://github.com/nvim-mini/mini.surround/
  {
    "nvim-mini/mini.surround",
    version = "*",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
      custom_surroundings = {
        ["c"] = { output = { left = "「", right = "」" } },
        ["u"] = { output = { left = " (", right = ") " } },
        ["z"] = { output = { left = "（", right = "）" } },
      },
    },
  },
}
