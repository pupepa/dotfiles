local ok, local_config = pcall(require, "rc.local")
local daily_notes_root = ok and local_config.daily_notes_root or vim.fn.stdpath("data") .. "/daily-notes"

return {
  {
    "fdavies93/daily-notes.nvim",
    cmd = { "DailyNote" },
    keys = {
      {
        "<Leader>dn",
        "<Cmd>:DailyNote<CR>",
        silent = true,
      },
    },
    opts = {
      writing = {
        root = daily_notes_root,
        day = {
          filename = "./%Y-%m-%d",
          template = "# %Y-%m-%d (%a)\n\n## 予定 \n\n---\n\n## タスク",
        },
      },
    },
  },
}
