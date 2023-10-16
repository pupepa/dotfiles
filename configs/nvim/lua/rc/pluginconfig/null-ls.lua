local null_ls = require("null-ls")

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local sources = {
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.diagnostics.eslint.with({
    prefer_local = "node_modules/.bin",
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  }),
  null_ls.builtins.formatting.eslint.with({
    prefer_local = "node_modules/.bin",
  }),
  null_ls.builtins.formatting.prettier.with({
    condition = function()
      return vim.fn.executable("prettier") > 0
    end,
    disabled_filetypes = { "markdown" },
    extra_filetypes = { "ruby" },
    prefer_local = "node_modules/.bin",
  }),
  null_ls.builtins.diagnostics.textlint.with({
    filetypes = { "markdown" },
    prefer_local = "$HOME/.asdf/shims/",
    timeout = 10000,
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  }),
  null_ls.builtins.formatting.rubocop.with({
    condition = function()
      return vim.fn.executable("rubocop") > 0
    end,
    extra_args = { "-A" },
  }),
  null_ls.builtins.formatting.swift_format.with({
    condition = function()
      return vim.fn.executable("swift-format") > 0
    end,
  }),
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
