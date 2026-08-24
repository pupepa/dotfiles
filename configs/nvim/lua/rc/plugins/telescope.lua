return {
  -- Find, Filter, Preview, Pick. All lua, all the time.
  -- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    keys = {
      {
        "<C-p>",
        function()
          require("telescope.builtin").find_files({ hidden = true })
        end,
        desc = "Find files (hidden)",
      },
      {
        "<Space>g",
        function()
          require("telescope").extensions.egrepify.egrepify()
        end,
        desc = "Live grep (egrepify)",
      },
      {
        "<Space>o",
        function()
          require("telescope").extensions.egrepify.egrepify({ default_text = vim.fn.expand("<cword>") })
        end,
        desc = "Live grep cword (egrepify)",
      },
      {
        "<Space>b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
      },
      {
        "<Space>c",
        function()
          require("telescope.builtin").command_history()
        end,
        desc = "Command history",
      },
      {
        "<Space>p",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume last picker",
      },
      { "<Space>q", "<Cmd>Telescope ghq list<CR>", desc = "ghq list" },
      { "<Space>r", "<Cmd>Telescope oldfiles<CR>", desc = "Old files" },
      {
        "<Space>l",
        function()
          require("telescope").extensions.lines.lines()
        end,
        desc = "Lines in buffer",
      },
      { "<Space>s", "<Cmd>Telescope git_status<CR>", desc = "Git status" },
      { "<Space>m", "<Cmd>Telescope memo list<CR>", desc = "Memo list" },
      {
        -- kensaku拡張は kensaku.vim → denops.vim (Deno) を引き連れてくるため、
        -- `config` の一括 `load_extension` には含めず押下時にロードする
        "<Space>e",
        function()
          require("telescope").load_extension("kensaku")
          vim.cmd("Telescope kensaku")
        end,
        desc = "Telescope kensaku",
      },
      {
        "<Space>d",
        function()
          local ok, local_config = pcall(require, "rc.local")
          local root = ok and local_config.daily_notes_root or vim.fn.stdpath("data") .. "/daily-notes"
          require("telescope.builtin").find_files({
            cwd = vim.fn.expand(root .. "/"),
            find_command = { "rg", "--files", "--color", "never", "--sortr", "path" },
          })
        end,
        desc = "Daily notes",
      },
    },
    -- telescope-ui-select は `vim.ui.select` を差し替えるが、本体を遅延させると
    -- 初回の `vim.lsp.buf.code_action()` 等で素の選択UIが出てしまう。
    -- 初回呼び出し時に telescope をロードし、差し替え後の実装へ委譲する
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "telescope.nvim" } })
        return vim.ui.select(...)
      end
    end,
    config = function()
      local status, telescope = pcall(require, "telescope")

      if not status then
        return
      end

      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            ".DS_Store",
            ".git/",
            "target/",
            "docs/",
            "vendor/*",
            "%.lock",
            "__pycache__/*",
            "%.sqlite3",
            "%.ipynb",
            "node_modules/*",
            "%.jpg",
            "%.jpeg",
            "%.png",
            "%.svg",
            "%.webp",
            ".dart_tool/",
            ".github/",
            ".gradle/",
            ".idea/",
            ".settings/",
            ".vscode/",
            "__pycache__/",
            "build/",
            "env/",
            "gradle/",
            "node_modules/",
            "%.pdb",
            "%.dll",
            "%.class",
            "%.exe",
            "%.cache",
            "%.ico",
            "%.pdf",
            "%.dylib",
            "%.jar",
            "%.docx",
            "%.met",
            "smalljre_*/*",
            ".vale/",
            "%.burp",
            "%.mp4",
            "%.mkv",
            "%.rar",
            "%.zip",
            "%.7z",
            "%.tar",
            "%.bz2",
            "%.epub",
            "%.flac",
            "%.tar.gz",
          },
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              mirror = false,
              prompt_position = "top",
              preview_width = 0.4,
            },
            vertical = { mirror = false },
            width = 0.8,
            height = 0.7,
          },
          mappings = {
            i = {
              ["qq"] = actions.close,
            },
            n = {
              ["q"] = actions.close,
              ["dd"] = actions.delete_buffer,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          },
        },
      })

      require("telescope").load_extension("lines")
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ghq")
      require("telescope").load_extension("gh")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("lazy")
      require("telescope").load_extension("egrepify")
      require("telescope").load_extension("memo")
    end,
  },

  -- Variable user customization for telescope.live_grep to set rg flags on-the-fly
  -- https://github.com/fdschmidt93/telescope-egrepify.nvim
  {
    "fdschmidt93/telescope-egrepify.nvim",
    lazy = true,
  },

  -- A simple Telescope extension to search through the lines in the current buffer
  -- https://github.com/neanias/telescope-lines.nvim
  {
    "neanias/telescope-lines.nvim",
    lazy = true,
  },

  -- https://github.com/nvim-telescope/telescope-ghq.nvim
  {
    "nvim-telescope/telescope-ghq.nvim",
    lazy = true,
  },

  -- Integration with github cli
  -- https://github.com/nvim-telescope/telescope-github.nvim
  {
    "nvim-telescope/telescope-github.nvim",
    lazy = true,
  },

  -- kensaku.vim + Telescope live grep
  -- https://github.com/Allianaab2m/telescope-kensaku.nvim
  {
    "Allianaab2m/telescope-kensaku.nvim",
    lazy = true,
    dependencies = { "lambdalisue/kensaku.vim" },
  },

  -- Telescope extension that provides handy functionality about plugins installed via lazy.nvim
  -- https://github.com/tsakirist/telescope-lazy.nvim
  {
    "tsakirist/telescope-lazy.nvim",
    lazy = true,
  },

  -- https://github.com/delphinus/telescope-memo.nvim
  {
    "delphinus/telescope-memo.nvim",
    lazy = true,
  },

  -- https://github.com/nvim-telescope/telescope-ui-select.nvim
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
  },

  -- FZF sorter for telescope written in c
  -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = true,
    build = "make",
  },
}
