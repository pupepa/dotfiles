return {
  -- ✍️ All the npm/yarn/pnpm commands I don't want to type
  -- https://github.com/vuki656/package-info.nvim
  {
    "vuki656/package-info.nvim",
    event = "BufRead package.json",
    opts = {},
  },
}
