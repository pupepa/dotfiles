vim.lsp.config("tailwindcss-language-server", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts", "tailwind.config.mjs" },
})
vim.lsp.enable("tailwindcss-language-server")

vim.lsp.config("denols", {
  cmd = { "deno", "lsp" },
  root_markers = {
    "deno.json",
    "deno.jsonc",
    "deps.ts",
  },
  workspace_required = true,
})

vim.lsp.config("oxlint", {
  root_markers = { ".oxlintrc.json", "oxlint.config.ts", "vite.config.ts", "vite.config.mts" },
})

vim.lsp.config("lua-language-server", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          align_continuous_rect_table_field = "false",
          align_continuous_inline_comment = "false",
          align_array_table = "false",
        },
      }
    },
  },
})

vim.lsp.config("bash-language-server", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
})

vim.lsp.config("sourcekit", {
  cmd = { "sourcekit-lsp" },
  filetypes = { "swift" },
})

vim.lsp.config("dockerfile-language-server", {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
})

vim.lsp.enable({
  "sourcekit",
  "denols",
  "oxlint",
  "lua-language-server",
  "bash-language-server",
  "dockerfile-language-server",
  "tailwindcss-language-server",
})
