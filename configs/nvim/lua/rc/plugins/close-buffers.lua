return {
  -- 📑 Delete multiple vim buffers based on different conditions
  -- https://github.com/kazhala/close-buffers.nvim
  {
    "kazhala/close-buffers.nvim",
    keys = {
      {
        "<leader>bo",
        ":lua require('close_buffers').delete({ type = 'other', force = true })<cr>",
        desc = "close other",
        silent = true,
      },
      {
        "<leader>bd",
        ":lua require('close_buffers').delete({ type = 'this', force = true })<cr>",
        desc = "close",
        silent = true,
      },
      {
        "<leader>bD",
        ":lua require('close_buffers').delete({ type = 'all', force = true })<cr>",
        desc = "close all",
        silent = true,
      },
    },
  },
}
