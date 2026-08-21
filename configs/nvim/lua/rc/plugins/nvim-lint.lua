return {
  -- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
  --https://github.com/mfussenegger/nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      local lint = require("lint")

      -- linter の cwd 判定に使うマーカー
      -- 1 グループにまとめることでマーカー順ではなく「近い階層順」で解決される
      -- npm workspace では tsconfig の paths (@/*) を解決させるため、
      -- ワークスペースルートではなくパッケージのディレクトリーを cwd にする
      local root_markers = {
        {
          "tsconfig.json",
          "jsconfig.json",
          "package.json",
          "pyproject.toml",
          "Cargo.toml",
          "deno.json",
          "deno.jsonc",
          ".git",
        },
      }

      -- npm と同じく、バッファーから上方向のすべての node_modules/.bin を集める
      -- モノレポのルートに hoist されたバイナリーもこれで解決できる
      local function bin_dirs(path)
        local dirs = {}
        for dir in vim.fs.parents(path) do
          local bin = dir .. "/node_modules/.bin"
          if vim.uv.fs_stat(bin) then
            table.insert(dirs, bin)
          end
        end

        return dirs
      end

      -- linter.env は加算ではなく置換なので、現在の環境変数をマージして渡す
      -- uv.spawn は env の PATH からコマンド名を解決するため、これだけで
      -- linter 定義を書き換えずにローカルのバイナリーが使われる
      local function make_env(dirs)
        local env = vim.fn.environ()
        local path = vim.list_extend({}, dirs)
        table.insert(path, env.PATH)
        env.PATH = table.concat(path, ":")

        return env
      end

      local function available(name, dirs)
        for _, dir in ipairs(dirs) do
          if vim.fn.executable(dir .. "/" .. name) == 1 then
            return true
          end
        end

        return vim.fn.executable(name) == 1
      end

      lint.linters.textlint = require("rc.lint.textlint")

      -- filetype ごとの候補。実行可能な最初の 1 つだけを使う
      local candidates_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck" },
        python = { "ruff" },
        deno = { "deno" },
        -- ruby = { "rubocop" },
        markdown = { "textlint" },
        review = { "textlint" },
        text = { "textlint" },
        javascript = { "oxlint", "eslint" },
        javascriptreact = { "oxlint", "eslint" },
        typescript = { "oxlint", "eslint" },
        typescriptreact = { "oxlint", "eslint" },
      }

      local function pick_linters(ft, dirs)
        -- typescript.tsx のような複合 filetype も解決する
        for _, part in ipairs(vim.split(ft, ".", { plain = true })) do
          for _, name in ipairs(candidates_by_ft[part] or {}) do
            if available(name, dirs) then
              return { name }
            end
          end
        end

        return {}
      end

      local function run_lint(bufnr)
        local path = vim.api.nvim_buf_get_name(bufnr)
        if vim.bo[bufnr].buftype ~= "" or path == "" then
          return
        end

        local dirs = bin_dirs(path)
        local root = vim.fs.root(bufnr, root_markers)
        local opts = { cwd = root }

        if #dirs > 0 then
          local env = make_env(dirs)
          opts.wrap_linter = function(linter)
            linter.env = env

            return linter
          end
        end

        lint.try_lint(pick_linters(vim.bo[bufnr].filetype, dirs), opts)

        -- .vale.ini はグローバル cwd ではなくプロジェクトルート基準で探す
        if root and vim.uv.fs_stat(root .. "/.vale.ini") and available("vale", dirs) then
          lint.try_lint({ "vale" }, opts)
        end
      end

      local lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function(args)
          -- try_lint はカレントバッファーに対して動くため、ずれている場合は走らせない
          if args.buf == vim.api.nvim_get_current_buf() then
            run_lint(args.buf)
          end
        end,
      })

      run_lint(vim.api.nvim_get_current_buf())
    end,
  },
}
