return {
  -- Control Xcode from Vim
  -- https://github.com/pupepa/vim-xcode-control
  {
    "pupepa/vim-xcode-control",
    ft = { "swift", "objc" },
    keys = {
      {
        "<Leader>xb",
        "<Plug>(xcode_control_build)",
        desc = "Xcode Build",
        silent = true,
      },
      {
        "<Leader>xr",
        "<Plug>(xcode_control_run)",
        desc = "Xcode Build and Run",
        silent = true,
      },
      {
        "<Leader>xc",
        "<Plug>(xcode_control_clean)",
        desc = "Xcode Clean",
        silent = true,
      },
      {
        "<Leader>xv",
        "<Plug>(xcode_control_refresh_canvas)",
        desc = "Xcode Refresh Canvas",
        silent = true,
      },
    },
  },
}
