local null_ls = require("null-ls")

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local sources = {
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.code_actions.eslint.with({
    prefer_local = "node_modules/.bin",
  }),
  null_ls.builtins.diagnostics.eslint.with({
    prefer_local = "node_modules/.bin",
  }),
  null_ls.builtins.formatting.eslint.with({
    prefer_local = "node_modules/.bin",
  }),
  null_ls.builtins.formatting.prettier.with({
    condition = function()
      return vim.fn.executable("prettier") > 0
    end,
    prefer_local = "node_modules/.bin",
  }),
  null_ls.builtins.diagnostics.textlint.with({ filetypes = { "markdown" } }),
}

null_ls.setup({
  sources = sources,
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = 0,
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 5000 })
        end,
      })
    end
  end,
})
