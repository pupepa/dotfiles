return {
  -- Realtime preview by Vim. (Markdown, reStructuredText, textile)
  -- https://github.com/previm/previm
  {
    "previm/previm",
    ft = { "markdown", "asciidoc" },
    cmd = { "PrevimOpen" },
    dependencies = {
      "tyru/open-browser.vim",
    },
    config = function()
      vim.g.previm_enable_realtime = 1
      vim.g.previm_code_language_show = 1
      vim.g.previm_disable_default_css = 1
      vim.g.previm_custom_css_path = vim.fn.stdpath("config") .. "/css/github-markdown.css"
    end,
  },
}
