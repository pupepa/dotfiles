require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "dockerls",
    "html",
    "jsonls",
    "solargraph",
    "lua_ls",
    "tailwindcss",
    "ts_ls",
    "vimls",
  },
})
