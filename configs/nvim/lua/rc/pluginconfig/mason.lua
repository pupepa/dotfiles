require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()
mason_lspconfig.setup_handlers({
  function(server_name)
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    local settings = {}

    if server_name == "sumneko_lua" then
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      }
    end

    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      settings = settings,
    })
  end,
})
