return {
  {
    "Bakudankun/BackAndForward.vim",
    keys = {
      { "<C-o>", "<Plug>(backandforward-back)", mode = "n", desc = "Back" },
      { "<C-i>", "<Plug>(backandforward-forward)", mode = "n", desc = "Forward" },
    },
    init = function()
      vim.g.backandforward_config = {
        define_commands = false,
      }
    end,
  },
}
