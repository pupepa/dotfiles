return {
  -- git.nvim is the simple clone of the plugin vim-fugitive which is written in Lua.
  -- https://github.com/dinhhuy258/git.nvim
  {
    "dinhhuy258/git.nvim",
    cmd = "Git",
    keys = {
      {
        "<leader>go",
        function()
          require("git.browse").open(false)
        end,
        desc = "Browse File",
      },
      {
        "<Leader>gc",
        "<Cmd>Git commit<CR>",
        desc = "Git Commit",
      },
    },
    opts = {
      default_mappings = false,
    },
  },
}
