return {
  -- https://github.com/yuki-yano/fuzzy-motion.vim
  {
    "yuki-yano/fuzzy-motion.vim",
    dependencies = {
      { "vim-denops/denops.vim" },
      { "lambdalisue/kensaku.vim" },
    },
    keys = {
      { "<Space><Space>", "<Cmd>FuzzyMotion<CR>", mode = { "n", "x" }, desc = "FuzzyMotion" },
      { "sl", "<Cmd>FuzzyMotion<CR>", mode = { "n", "x" }, desc = "FuzzyMotion" },
    },
    init = function()
      vim.g.fuzzy_motion_matchers = { "kensaku", "fzf" }
    end,
  },
}
