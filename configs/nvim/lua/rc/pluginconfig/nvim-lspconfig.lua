local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")

local M = {}

local on_attach = function(client, bufnr)
  -- If the LSP supports formatting, allow for format-on-save through LSP
  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end
M.on_attach = on_attach

local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.sourcekit.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

return M
