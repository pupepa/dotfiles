return {
  -- ⚡ TypeScript integration NeoVim deserves ⚡
  -- https://github.com/pmizio/typescript-tools.nvim
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "typescript.tsx" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
