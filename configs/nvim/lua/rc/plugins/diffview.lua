return {
  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev (actively maintained fork).
  -- https://github.com/dlyongemallo/diffview.nvim
  {
    "dlyongemallo/diffview.nvim",
    version = "*",
    keys = {
      {
        "<leader>gd",
        "<Cmd>DiffviewOpen<CR>",
        desc = "Diffview Open",
        silent = true,
      },
      {
        "<leader>gt",
        "<Cmd>DiffviewToggle<CR>",
        desc = "Diffview Toggle",
        silent = true,
      },
      {
        "<leader>gh",
        "<Cmd>DiffviewFileHistory<CR>",
        desc = "Diffview File History",
        silent = true,
      },
      {
        "<leader>gf",
        "<Cmd>DiffviewDiffFiles<CR>",
        desc = "Diffview Diff Files",
        silent = true,
      },
      {
        "<leader>gl",
        "<Cmd>DiffviewLog<CR>",
        desc = "Diffview Log",
        silent = true,
      }
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewToggle",
      "DiffviewFileHistory",
      "DiffviewDiffFiles",
      "DiffviewLog",
    },
  },
}
