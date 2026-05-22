return {
  -- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
  --https://github.com/mfussenegger/nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      local lint = require("lint")

      local function pick_linters(linters)
        for _, l in ipairs(linters) do
          if lint.linters[l] and vim.fn.executable(lint.linters[l].cmd()) == 1 then
            return { l }
          end
        end

        return {}
      end

      lint.linters.textlint = require("rc.lint.textlint")

      local function make_linters_by_ft()
        return {
          lua = { "selene" },
          sh = { "shellcheck" },
          bash = { "shellcheck" },
          zsh = { "shellcheck" },
          python = { "ruff" },
          javascript = pick_linters({ "oxlint", "eslint" }),
          javascriptreact = pick_linters({ "oxlint", "eslint" }),
          typescript = pick_linters({ "oxlint", "eslint" }),
          typescriptreact = pick_linters({ "oxlint", "eslint" }),
          deno = { "deno" },
          ruby = { "rubocop" },
          markdown = { "textlint" },
          review = { "textlint" },
          text = { "textlint" },
        }
      end

      lint.linters_by_ft = make_linters_by_ft()

      lint.try_lint()

      local lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          require("lint").try_lint()

          if vim.fn.filereadable(".vale.ini") > 0 then
            require("lint").try_lint({ "vale" })
          end
        end,
      })
    end,
  },
}
