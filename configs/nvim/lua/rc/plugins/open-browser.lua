return {
  -- Open URI with your favorite browser from your most favorite editor
  -- https://github.com/tyru/open-browser.vim
  {
    "tyru/open-browser.vim",
    keys = {
      {
        "gx",
        "<Plug>(openbrowser-smart-search)",
        mode = { "n", "v" },
        remap = true,
      },
    },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw's gx mapping.
    end,
  },
}
