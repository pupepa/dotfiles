return {
  -- VSCode-style diff, merge and git history for Neovim. Side-by-side or inline, with character-level highlighting from VSCode's own diff algorithm in C.
  -- https://github.com/esmuellert/codediff.nvim
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    keys = {
      {
        "<leader>gd",
        "<Cmd>CodeDiff<CR>",
        desc = "CodeDiff Open",
        silent = true,
      },
      {
        "<leader>gH",
        "<Cmd>CodeDiff history<CR>",
        desc = "CodeDiff File History",
        silent = true,
      },
      {
        "<leader>gH",
        ":CodeDiff history<CR>",
        mode = "x",
        desc = "CodeDiff File History (line range)",
        silent = true,
      },
      {
        "<leader>gf",
        ":CodeDiff file ",
        desc = "CodeDiff Diff Files",
      },
    },
    opts = {
      highlights = {
        char_brightness = 2.0
      },
      explorer = {
        width = 50,
        auto_open_on_cursor = true,
        view_mode = "tree", -- "list" or "tree"
        line_stats = {
          enabled = true,
        },
      },
      diff = {
        compact = true,
        compact_context_lines = 8,
        compact_sync_folds = true, -- open/close folds in both panes together
      },
      keymaps = {
        view = {},
      },
    }
  },
}
