return {
  -- Run commands quickly.
  -- https://github.com/thinca/vim-quickrun
  {
    "thinca/vim-quickrun",
    cmd = { "QuickRun" },
    init = function()
      vim.g.quickrun_config = {
        _ = {
          runner = "system",
        },
        markdown = {
          outputter = "null",
          command = "open",
          cmdopt = "-a",
          args = "/Applications/Google\\ Chrome.app",
          exec = "%c %o %a %s",
        },
        ["ruby.bundle"] = {
          command = "ruby",
          cmdopt = "bundle exec",
          exec = "%o %c %s",
        },
        ["markdown.marp"] = {
          command = "marp",
          cmdopt = "--theme-set ./marp-themes/test.css -p",
          runner = "terminal",
          exec = "%c %o %s",
        },
      }
    end,
  },
}
