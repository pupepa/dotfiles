return {
  -- cd project root automatically
  -- https://github.com/wsdjeg/rooter.nvim
  {
    "wsdjeg/rooter.nvim",
    opts = {
      root_patterns = { "Gemfile", ".git/", "package.json" },
      outermost = false,
    },
  },
}
