return {
  -- A plugin for profiling Vim and Neovim startup time.
  -- https://github.com/dstein64/vim-startuptime
  {
    "dstein64/vim-startuptime",
    cmd = { "StartupTime" },
    init = function()
      vim.g.startuptime_event_width = 100
    end,
  },
}
