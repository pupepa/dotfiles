return {
  -- Lightweight yet powerful formatter plugin for Neovim
  -- https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
      local javascript_formatters = { "oxfmt", "prettier", stop_after_first = true, lsp_format = "fallback" }
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = javascript_formatters,
          javascriptreact = javascript_formatters,
          python = { "ruff_format", lsp_format = "fallback" },
          swift = { "swift_format" },
          typescript = javascript_formatters,
          typescriptreact = javascript_formatters,
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  },
}
