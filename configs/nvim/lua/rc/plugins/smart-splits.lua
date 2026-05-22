return {
  -- 🧠 Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of "up/down/left/right".
  -- https://github.com/mrjones2014/smart-splits.nvim
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      at_edge = "stop",
    },
    keys = {
      -- focus windows
      {
        "<C-h>",
        "<cmd>lua require('smart-splits').move_cursor_left()<cr>",
        desc = "Focus Window Left",
      },
      {
        "<C-l>",
        "<cmd>lua require('smart-splits').move_cursor_right()<cr>",
        desc = "Focus Window Right",
      },
      {
        "<C-j>",
        "<cmd>lua require('smart-splits').move_cursor_down()<cr>",
        desc = "Focus Window Down",
      },
      {
        "<C-k>",
        "<cmd>lua require('smart-splits').move_cursor_up()<cr>",
        desc = "Focus Window Up",
      },

      -- resize windows
      {
        "<S-Left>",
        "<cmd>lua require('smart-splits').resize_left()<cr>",
        desc = "Resize Window Left",
      },
      {
        "<S-Right>",
        "<cmd>lua require('smart-splits').resize_right()<cr>",
        desc = "Resize Window Right",
      },
      {
        "<S-Down>",
        "<cmd>lua require('smart-splits').resize_down()<cr>",
        desc = "Resize Window Down",
      },
      {
        "<S-Up>",
        "<cmd>lua require('smart-splits').resize_up()<cr>",
        desc = "Resize Window Up",
      },
    },
    event = "VeryLazy",
    -- lazy = true,
  },
}
