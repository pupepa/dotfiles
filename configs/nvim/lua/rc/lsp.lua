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

vim.lsp.config("dockerfile-language-server", {
  cmd = { "docker-language-server", "start", "--stdio" },
  filetypes = { "dockerfile", "yaml.docker-compose" },
  get_language_id = function(_, ftype)
    if ftype == "yaml.docker-compose" or ftype:lower():find("ya?ml") then
      return "dockercompose"
    else
      return ftype
    end
  end,
  root_markers = {
    "Dockerfile",
    "docker-compose.yaml",
    "docker-compose.yml",
    "compose.yaml",
    "compose.yml",
    "docker-bake.json",
    "docker-bake.hcl",
    "docker-bake.override.json",
    "docker-bake.override.hcl",
  },
})

vim.lsp.config("sqls", {
  cmd = { "sqls" },
  filetypes = { "sql", "mysql" },
  root_markers = { "config.yml" },
})

vim.lsp.config("ruby_lsp", {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" },
})

-- rootから上方向に `node_modules/typescript`を探す (モノレポでルートに巻き上げられている場合に対応)
local function find_typescript(root)
  local dir = root

  while true do
    local path = dir .. "/node_modules/typescript"

    if vim.uv.fs_stat(path .. "/package.json") then
      return path
    end

    local parent = vim.fs.dirname(dir)

    if parent == dir then
      return nil
    end

    dir = parent
  end
end

-- TypeScriptパッケージのメジャーバージョンを返す
local function ts_major(ts_dir)
  local ok, pkg = pcall(function()
    return vim.json.decode(table.concat(vim.fn.readfile(ts_dir .. "/package.json"), "\n"))
  end)

  if not ok or type(pkg.version) ~= "string" then
    return nil
  end

  return tonumber(pkg.version:match("^(%d+)"))
end

-- `match(major)` が真になるTypeScriptがインストールされたプロジェクトでのみ起動する
local function root_for(match)
  return function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, { "tsconfig.json", "package.json" })
    local ts_dir = root and find_typescript(root)
    local major = ts_dir and ts_major(ts_dir)

    if major and match(major) then
      on_dir(root)
    end
  end
end

local ts_filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }

-- TypeScript 6以下 (tsserver) 用。tsserverはプロジェクトのtypescriptを上方向に探して使う
vim.lsp.config("ts6_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = ts_filetypes,
  root_dir = root_for(function(major) return major <= 6 end),
})

vim.lsp.config("ts7_ls", {
  cmd = function(dispatchers, config)
    local bin = vim.fs.dirname(find_typescript(config.root_dir)) .. "/.bin/tsc"

    return vim.lsp.rpc.start({ bin, "--lsp", "--stdio" }, dispatchers, { cwd = config.root_dir })
  end,
  filetypes = ts_filetypes,
  root_dir = root_for(function(major) return major >= 7 end),
})

vim.lsp.enable({
  "sourcekit",
  "denols",
  "oxlint",
  "lua-language-server",
  "bash-language-server",
  "dockerfile-language-server",
  "tailwindcss-language-server",
  "sqls",
  "ruby_lsp",
  "ts6_ls",
  "ts7_ls",
})
