return {
  -- https://github.com/yuki-yano/fuzzy-motion.vim
  {
    "yuki-yano/fuzzy-motion.vim",
    event = "VeryLazy",
    dependencies = {
      { "vim-denops/denops.vim" },
      { "lambdalisue/kensaku.vim" },
    },
    init = function()
      vim.g.fuzzy_motion_matchers = { "kensaku", "fzf" }

      vim.keymap.set({ "n", "x" }, "<Space><Space>", "<Cmd>FuzzyMotion<CR>")
      vim.keymap.set({ "n", "x" }, "sl", "<Cmd>FuzzyMotion<CR>")
    end,
  },
}
