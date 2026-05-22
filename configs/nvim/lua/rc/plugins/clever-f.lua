return {
  -- Extended f, F, t and T key mappings for Vim.
  -- https://github.com/rhysd/clever-f.vim
  {
    "rhysd/clever-f.vim",
    event = "BufReadPost",
    init = function()
      vim.g.clever_f_show_prompt = 1
      vim.g.clever_f_use_migemo = 0
      vim.g.clever_f_across_no_line = 1
    end,
  },
}
