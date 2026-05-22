return {
  --URL highlight everywhere
  -- https://github.com/itchyny/vim-highlighturl
  {
    "itchyny/vim-highlighturl",
    event = "BufReadPost",
    init = function()
      vim.g.highlighturl_url_priority = 10
    end,
  },
}
