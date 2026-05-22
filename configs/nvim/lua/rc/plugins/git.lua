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
          local status, git = pcall(require, "git")
          if status then
            git.setup({
              default_mappings = false,
              keymaps = {
                browse = "<Leader>go",
              },
            })
          end
        end,
        desc = "Browse File",
      },
      {
        "<Leader>gc",
        "<Cmd>Git commit<CR>",
        desc = "Git Commit",
      },
    },
    config = true
  },
}
