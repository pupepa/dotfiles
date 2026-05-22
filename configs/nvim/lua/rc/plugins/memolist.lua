return {
  -- simple memo plugin for Vim.
  -- https://github.com/glidenote/memolist.vim
  {
    "glidenote/memolist.vim",
    cmd = { "MemoNew", "MemoList", "MemoGrep" },
    keys = {
      { "<Leader>mn", "<cmd>MemoNew<CR>", desc = "New memo" },
    },
    init = function()
      vim.g.memolist_path = "$HOME/Documents/memolist"
      vim.g.memolist_memo_suffix = "md"
      vim.g.memolist_denite = 0
    end,
  },
}
