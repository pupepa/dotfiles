local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({

  ------------------------------------------------------------------------------
  -- Lua Library
  ------------------------------------------------------------------------------

  -- [WIP] An implementation of the Popup API from vim in Neovim. Hope to upstream when complete
  -- https://github.com/nvim-lua/popup.nvim
  {
    "nvim-lua/popup.nvim",
    lazy = true,
  },

  -- All the lua functions I don't want to write twice.
  -- https://github.com/nvim-lua/plenary.nvim
  { "nvim-lua/plenary.nvim" }, -- do not lazy load

  -- SQLite LuaJIT binding with a very simple api.
  -- https://github.com/kkharji/sqlite.lua
  { "kkharji/sqlite.lua", lazy = true },

  -- UI Component Library for Neovim.
  -- https://github.com/MunifTanjim/nui.nvim
  { "MunifTanjim/nui.nvim", lazy = true },

  -- Better quickfix window in Neovim, polish old quickfix window.
  -- https://github.com/kevinhwang91/nvim-bqf
  { "kevinhwang91/nvim-bqf", ft = "qf" },

  --------------------------------------------------------------------------------
  -- LSP & Completion
  --------------------------------------------------------------------------------

  -- External package Installer
  -- https://github.com/williamboman/mason.nvim
  {
    "williamboman/mason.nvim",
    dependencies = {
      -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
      -- https://github.com/williamboman/mason-lspconfig.nvim
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
    },
    event = "BufReadPre",
    config = function()
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
    end,
  },

  -- null-ls.nvim reloaded / Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  -- https://github.com/nvimtools/none-ls.nvim
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

      local sources = {
        null_ls.builtins.formatting.stylua,

        require("none-ls.diagnostics.eslint").with({
          prefer_local = "node_modules/.bin",
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
        }),
        require("none-ls.formatting.eslint").with({
          prefer_local = "node_modules/.bin",
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
        }),

        null_ls.builtins.formatting.prettier.with({
          condition = function()
            return vim.fn.executable("prettier") > 0 or vim.fn.executable("./node_modules/.bin/prettier") > 0
          end,
          disabled_filetypes = { "markdown" },
          extra_filetypes = { "ruby" },
          prefer_local = "node_modules/.bin",
        }),

        null_ls.builtins.diagnostics.textlint.with({
          filetypes = { "markdown" },
          timeout = 10000,
          method = null_ls.methods.DIAGNOSTICS,
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
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          "Makefile",
          ".git",
          "package.json",
          "tsconfig.json",
          ".eslintrc",
          ".prettierrc",
          "deno.json",
          "Gemfile"
        ),
        sources = sources,
        on_attach = function(client, bufnr)
          local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
          if filetype ~= "markdown" and client.server_capabilities.documentFormattingProvider then
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
    end,
  },

  -- A completion plugin for neovim coded in Lua.
  -- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
      -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- nvim-cmp source for buffer words.
      -- https://github.com/hrsh7th/cmp-buffer
      "hrsh7th/cmp-buffer",
      -- nvim-cmp source for filesystem paths.
      -- https://github.com/hrsh7th/cmp-path
      "hrsh7th/cmp-path",
      -- nvim-cmp source for neovim Lua API.
      -- https://github.com/hrsh7th/cmp-nvim-lua
      "hrsh7th/cmp-nvim-lua",
      -- nvim-cmp source for emojis.
      -- https://github.com/hrsh7th/cmp-emoji
      "hrsh7th/cmp-emoji",

      -- nvim-cmp source for math calculation.
      -- https://github.com/hrsh7th/cmp-calc
      "hrsh7th/cmp-calc",

      -- spell source for nvim-cmp based on vim's spellsuggest.
      -- https://github.com/f3fora/cmp-spell
      "f3fora/cmp-spell",

      -- cmp source for treesitter
      -- https://github.com/ray-x/cmp-treesitter
      "ray-x/cmp-treesitter",

      "dcampos/cmp-snippy",

      "andersevenrud/cmp-tmux",

      "roobert/tailwindcss-colorizer-cmp.nvim",

      -- nvim-cmp source for vim's cmdline
      -- https://github.com/hrsh7th/cmp-cmdline
      { "hrsh7th/cmp-cmdline" },

      "cmp-nvim-lsp",

      -- nvim-cmp comparator function for completion items that start with one or more underlines
      -- https://github.com/lukas-reineke/cmp-under-comparator
      {
        "lukas-reineke/cmp-under-comparator",
      },
    },
    opts = function()
      local cmp = require("cmp")

      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      return {
        formatting = {
          format = require("lspkind").cmp_format({
            with_text = true,
            maxwidth = 50,
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              snippy = "[Snippet]",
              nvim_lua = "[NeovimLua]",
              path = "[Path]",
              omni = "[Omni]",
              spell = "[Spell]",
              emoji = "[Emoji]",
              calc = "[Calc]",
              rg = "[Rg]",
              treesitter = "[TS]",
              dictionary = "[Dictionary]",
              mocword = "[mocword]",
              cmdline_history = "[History]",
              tmux = "[tmux]",
            },
            before = require("tailwindcss-colorizer-cmp").formatter,
          }),
        },
        mapping = {
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<Up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              vim.api.nvim_feedkeys(t("<Up>"), "n", true)
            end
          end, { "i" }),

          ["<Down>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              vim.api.nvim_feedkeys(t("<Down>"), "n", true)
            end
          end, { "i" }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if require("copilot.suggestion").is_visible() then
              require("copilot.suggestion").accept()
            elseif cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-Down>"] = cmp.mapping(function(fallback)
            fallback()
          end, { "i", "s" }),

          ["<C-Up>"] = cmp.mapping(function(fallback)
            fallback()
          end, { "i", "s" }),

          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-q>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        },

        snippet = {
          expand = function(args)
            require("snippy").expand_snippet(args.body)
          end,
        },

        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require("cmp-under-comparator").under,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "lazydev", group_index = 0 },
          { name = "copilot" },
          { name = "snippy" },
          { name = "path" },
          { name = "emoji", insert = true },
          { name = "nvim_lua" },
          { name = "nvim_lsp_signature_help" },
        }, {
          { name = "buffer" },
          { name = "calc" },
          { name = "treesitter" },
          { name = "dictionary" },
          { name = "mocword" },
          { name = "spell" },
          { name = "tmux" },
        }),

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline({
          ["<Down>"] = { c = cmp.mapping.select_next_item() },
          ["<Up>"] = { c = cmp.mapping.select_prev_item() },
        }),
        sources = {
          { name = "buffer" },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<Down>"] = { c = cmp.mapping.select_next_item() },
          ["<Up>"] = { c = cmp.mapping.select_prev_item() },
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
    end,
  },

  -- vscode-like pictograms for neovim lsp completion items
  -- https://github.com/onsails/lspkind.nvim
  {
    "onsails/lspkind-nvim",
    lazy = true,
    config = function()
      require("lspkind").init({
        -- enables text annotations
        --
        -- default: true
        mode = "symbol_text",

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = "codicons",

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
          Namespace = "󰌗",
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰆧",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈚",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰊄",
          Table = "",
          Object = "󰅩",
          Tag = "",
          Array = "[]",
          Boolean = "",
          Number = "",
          Null = "󰟢",
          Supermaven = "",
          String = "󰉿",
          Calendar = "",
          Watch = "󰥔",
          Package = "",
          Copilot = "",
          Codeium = "",
          TabNine = "",
        },
      })
    end,
  },

  {
    "dcampos/cmp-snippy",
    lazy = true,
    dependencies = { "dcampos/nvim-snippy" },
  },

  -- nvim-cmp source for neovim builtin LSP client
  -- https://github.com/hrsh7th/cmp-nvim-lsp
  { "hrsh7th/cmp-nvim-lsp", lazy = true },

  -- nippet plugin for Neovim
  -- https://github.com/dcampos/nvim-snippy
  {
    "dcampos/nvim-snippy",
    lazy = true,
    opts = { snippet_dirs = { "~/.config/nvim/snippets", "~/.config/nvim/snippets_private" } },
  },

  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
  -- https://github.com/williamboman/mason-lspconfig.nvim
  { "williamboman/mason-lspconfig.nvim" },

  -- Faster LuaLS setup for Neovim
  -- https://github.com/folke/lazydev.nvim
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        {
          path = "luvit-meta/library",
          words = { "vim%.uv" },
        },
      },
    },
  },

  -- Meta type definitions for the Lua platform Luvit.
  -- https://github.com/Bilal2453/luvit-meta
  {
    "Bilal2453/luvit-meta",
    lazy = true,
  }, -- optional `vim.uv` typings

  -- Quickstart configs for Nvim LSP
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "glepnir/lspsaga.nvim",
      "nvim-lualine/lualine.nvim",
    },
  },

  -- neovim lsp plugin
  -- https://github.com/glepnir/lspsaga.nvim
  {
    "glepnir/lspsaga.nvim",
    event = "BufReadPre",
    dependencies = {
      "nvim-lualine/lualine.nvim",
    },
    keys = {
      { "gn", "<Cmd>Lspsaga code_action<CR>", desc = "Code action", silent = true },
      { "gn", ":<C-u>Lspsaga range_code_action<CR>", mode = "x", desc = "Range code action", silent = true },
      { "gh", "<Cmd>Lspsaga hover_doc<CR>", desc = "Hover documentation", silent = true },
      { "go", "<Cmd>Lspsaga goto_definition<CR>", desc = "Go to definition", silent = true },
      { "gr", "<Cmd>Lspsaga finder<CR>", desc = "Find references", silent = true },
      { "gl", "<Cmd>Lspsaga outline<CR>", desc = "Show outline", silent = true },
      { "gp", "<Cmd>Lspsaga panel<CR>", desc = "Show panel", silent = true },
      { "]g", "<Cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic", silent = true },
      { "[g", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous diagnostic", silent = true },
    },
    opts = {
      lightbulb = {
        enable = false,
      },
      outline = {
        win_position = "right",
        auto_preview = true,
        detail = true,
        auto_close = true,
        close_after_jump = true,
        layout = "float",
        keys = {
          toggle_or_jump = "<cr>",
          quit = { "q", "<ESC>" },
          jump = "e",
        },
      },
    },
  },

  -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {},
  },

  -- Standalone UI for nvim-lsp progress
  -- https://github.com/j-hui/fidget.nvim
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    opts = {},
  },

  -- 🌈 A Neovim plugin to add vscode-style TailwindCSS completion to nvim-cmp
  -- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    lazy = true,
    opts = {
      color_square_width = 2,
    },
  },

  -- https://github.com/zbirenbaum/copilot-cmp
  {
    "zbirenbaum/copilot-cmp",
    lazy = true,
    opts = {},
  },

  -----------------------------------------------------------------------------------------
  -- Treesitter
  -----------------------------------------------------------------------------------------

  -- Nvim Treesitter configurations and abstraction layer
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "css",
          "diff",
          "dockerfile",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "html",
          "javascript",
          "json",
          "lua",
          "ruby",
          "sql",
          "swift",
          "toml",
          "tsx",
          "typescript",
        },
        highlight = {
          enable = true,
          disable = { "asciidoc", "vim" },
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["a,"] = "@parameter.inner",
              ["i,"] = "@parameter.outer",
            },
          },
        },
        ignore_install = {},
        sync_install = false,
        auto_install = true,
        modules = {},
      })
    end,
  },

  -- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
  },

  -----------------------------------------------------------------------------------------
  -- Fuzzy Finder
  -----------------------------------------------------------------------------------------

  -- Find, Filter, Preview, Pick. All lua, all the time.
  -- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
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

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<C-p>", function()
        builtin.find_files({ hidden = true })
      end, { silent = true })

      vim.keymap.set("n", "<Space>g", require("telescope").extensions.egrepify.egrepify)
      vim.keymap.set(
        "n",
        "<Space>o",
        "<Cmd>lua require('telescope').extensions.egrepify.egrepify({ default_text = vim.fn.expand('<cword>') })<CR>",
        { silent = true }
      )
      -- vim.keymap.set("n", "<Space>g", builtin.live_grep, {})
      vim.keymap.set("n", "<Space>b", builtin.buffers, {})
      vim.keymap.set("n", "<Space>c", builtin.command_history, {})
      vim.keymap.set("n", "<Space>p", builtin.resume, {})
      vim.keymap.set("n", "<Space>q", "<Cmd>:Telescope ghq list<CR>", { silent = true })
      vim.keymap.set("n", "<Space>r", "<Cmd>:Telescope oldfiles<CR>", { silent = true })
      vim.keymap.set("n", "<Space>l", "<Cmd>lua require('telescope').extensions.lines.lines()<CR>", { silent = true })
      vim.keymap.set("n", "<Space>s", "<Cmd>:Telescope git_status<CR>", { silent = true })
      vim.keymap.set("n", "<Space>m", "<Cmd>:Telescope memo list<CR>", { silent = true })
      vim.keymap.set("n", "<Space>e", "<Cmd>:Telescope kensaku<CR>", { silent = true })

      require("telescope").load_extension("lines")
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ghq")
      require("telescope").load_extension("gh")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("kensaku")
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
  },

  -- Telescope extension that provides handy functionality about plugins installed via lazy.nvim
  -- https://github.com/tsakirist/telescope-lazy.nvim
  {
    "tsakirist/telescope-lazy.nvim",
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

  -----------------------------------------------------------------------------------------
  -- UI
  -----------------------------------------------------------------------------------------

  -- A highly customizable theme for vim and neovim with support for lsp, treesitter and a variety of plugins.
  -- https://github.com/EdenEast/nightfox.nvim
  {
    "EdenEast/nightfox.nvim",
    event = { "BufReadPre", "BufWinEnter" },
    config = function()
      vim.cmd.colorscheme("nightfox")

      -- Create symlink for WezTerm colorscheme
      -- local function create_symlink_for_wezterm()
      --   local wezterm_colors_path = vim.env.XDG_CONFIG_HOME .. "/wezterm/colors"
      --   if vim.fn.isdirectory(wezterm_colors_path) == 0 then
      --     vim.fn.mkdir(wezterm_colors_path, "p")
      --   end
      --
      --   local wezterm_color_scheme_filename = "nightfox_wezterm.toml"
      --   local wezterm_color_scheme_path = vim.env.XDG_CONFIG_HOME
      --     .. "/nvim/plugged/nightfox.nvim/extra/nightfox/"
      --     .. wezterm_color_scheme_filename
      --   local target_path = wezterm_colors_path .. "/" .. wezterm_color_scheme_filename
      --
      --   if vim.fn.filereadable(target_path) == 0 then
      --     vim.fn.system("ln -s " .. wezterm_color_scheme_path .. " " .. target_path)
      --     print("Create symlink for wezterm colorscheme")
      --   end
      -- end

      -- Uncomment to create symlink automatically
      -- create_symlink_for_wezterm()

      vim.api.nvim_set_hl(0, "@markup.raw.block", { fg = "#c0c0c0" })
    end,
  },

  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = { "EdenEast/nightfox.nvim" },
    config = function()
      -- +-------------------------------------------------+
      -- | A | B | C                             X | Y | Z |
      -- +-------------------------------------------------+
      --
      local function selectionCount()
        local mode = vim.fn.mode()
        local start_line, end_line, start_pos, end_pos

        -- 選択モードでない場合には無効
        if not (mode:find("[vV\22]") ~= nil) then
          return ""
        end

        start_line = vim.fn.line("v")
        end_line = vim.fn.line(".")

        local lines = math.abs(end_line - start_line) + 1
        return tostring(lines) .. " lines"
      end

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = {
            { selectionCount },
          },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      })
    end,
  },

  -- A snazzy bufferline for Neovim
  -- https://github.com/akinsho/bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    branch = "main",
    event = "BufReadPost",
    lazy = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "buffers",
        indicator_style = "▎",
        diagnostics = "nvim_lsp",
        modified_icon = "●",
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        get_element_icon = function(buf)
          local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(buf.filetype, { default = false })
          return icon, hl
        end,
        show_close_icon = false,
        show_tab_indicators = false,
        persist_buffer_sort = false,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        numbers = function(opts)
          return string.format("%s)", opts.id)
        end,
      },
    },
  },

  --URL highlight everywhere
  -- https://github.com/itchyny/vim-highlighturl
  {
    "itchyny/vim-highlighturl",
    event = "BufReadPost",
    init = function()
      vim.g.highlighturl_url_priority = 10
    end,
  },

  -- Hlsearch Lens for Neovim
  -- https://github.com/kevinhwang91/nvim-hlslens
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
      require("hlslens").setup({})

      vim.keymap.set("n", "n", function()
        local ok, err = pcall(function()
          vim.cmd.normal({ args = { vim.v.count1 .. "n" }, bang = true })
        end)
        if ok then
          require("hlslens").start()
        else
          -- エラーメッセージを表示（オプション）
          -- vim.notify("End of bottom", vim.log.levels.WARN)
        end
      end)

      vim.keymap.set("n", "N", function()
        local ok, err = pcall(function()
          vim.cmd.normal({ args = { vim.v.count1 .. "N" }, bang = true })
        end)
        if ok then
          require("hlslens").start()
        else
          -- vim.notify(err, vim.log.levels.WARN)
        end
      end)

      local hlslens = require("hlslens")
      vim.keymap.set("n", "*", function()
        local current_word = vim.fn.expand("<cword>")
        vim.fn.histadd("search", current_word)
        vim.fn.setreg("/", current_word)
        vim.opt.hlsearch = true
        hlslens.start()
      end)

      vim.keymap.set("n", "#", function()
        local current_word = vim.fn.expand("<cword>")
        vim.api.nvim_feedkeys(":%s/" .. current_word .. "//g", "n", false)
        -- :%s/word/CURSOR/g
        local ll = vim.api.nvim_replace_termcodes("<Left><Left>", true, true, true)
        vim.api.nvim_feedkeys(ll, "n", false)
        vim.opt.hlsearch = true
        hlslens.start()
      end)

      local function getVisualSelection()
        vim.cmd.normal({ args = { '"vy' }, bang = true, mods = { noautocmd = true } })
        local text = vim.fn.getreg("v")
        vim.fn.setreg("v", {})

        if #text > 0 then
          return text
        else
          return ""
        end
      end

      vim.keymap.set("v", "*", function()
        local current_word = getVisualSelection()
        current_word = vim.fn.substitute(vim.fn.escape(current_word, "\\"), "\\n", "\\\\n", "g")
        vim.fn.histadd("search", current_word)
        vim.fn.setreg("/", current_word)
        vim.opt.hlsearch = true
        hlslens.start()
      end)

      vim.keymap.set("v", "#", function()
        local current_word = getVisualSelection()
        current_word = vim.fn.substitute(vim.fn.escape(current_word, "\\"), "\\n", "\\\\n", "g")
        vim.api.nvim_feedkeys(":%s/" .. current_word .. "//g", "n", false)
        -- :%s/word/CURSOR/g
        local ll = vim.api.nvim_replace_termcodes("<Left><Left>", true, true, true)
        vim.api.nvim_feedkeys(ll, "n", false)
        vim.opt.hlsearch = true
        hlslens.start()
      end)
    end,
    -- config = function()
    --   require("rc/pluginconfig/nvim-hlslens")
    -- end,
  },

  -- Git integration for buffers
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    event = { "FocusLost", "CursorHold" },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "<leader>gb", gs.toggle_current_line_blame)
      end,
    },
  },

  -- Indent guides for Neovim
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      show_current_context = true,
      show_current_context_start = true,
    },
  },

  -- illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
  -- https://github.com/RRethy/vim-illuminate
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 100,
        filetypes_denylist = {
          "dirvish",
          "help",
          "packer",
          "toggleterm",
        },
        under_cursor = false,
      })

      vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end,
  },

  -- A fancy, configurable, notification manager for NeoVim
  -- https://github.com/rcarriga/nvim-notify
  {
    "rcarriga/nvim-notify",
    event = "BufReadPre",
    config = function()
      local notify = require("notify")

      notify.setup({
        ---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
        stjges = "fade",
        ---@usage Function called when a new window is opened, use for changing win settings/config
        on_open = nil,
        ---@usage Function called when a window is closed
        on_close = nil,
        ---@usage timeout for notifications in ms, default 5000
        timeout = 5000,
        -- @usage User render fps value
        fps = 30,
        -- Render function for notifications. See notify-render()
        render = "default",
        ---@usage highlight behind the window for stages that change opacity
        background_colour = "Normal",
        ---@usage minimum width for notification windows
        minimum_width = 50,
        ---@usage notifications with level lower than this would be ignored. [ERROR > WARN > INFO > DEBUG > TRACE]
        level = "TRACE",
        ---@usage Icons for the different levels
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "",
        },
        top_down = false,
        merge_duplicates = true,
      })

      vim.notify = notify
    end,
  },

  -- Prismatic line decorations for the adventurous vim user
  -- https://github.com/mvllow/modes.nvim
  {
    "mvllow/modes.nvim",
    event = "ModeChanged",
    tag = "v0.2.1",
    opts = {
      line_opacity = 0.2,
    },
  },

  -- Rainbow delimiters for Neovim with Tree-sitter
  -- https://github.com/hiphish/rainbow-delimiters.nvim
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    submodules = false,
    config = function()
      -- patch https://github.com/nvim-treesitter/nvim-treesitter/issues/1124
      vim.cmd.edit({ bang = true })
    end,
  },

  -- Virtual text context for neovim treesitter
  -- https://github.com/andersevenrud/nvim_context_vt
  {
    "haringsrob/nvim_context_vt",
    event = "BufReadPost",
    opts = {},
  },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  -- https://github.com/folke/noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "hrsh7th/nvim-cmp",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      routes = {
        {
          filter = { event = "notify", find = "No information available" },
          opts = { skip = true },
        },
      },
      messages = {
        view_search = false, -- use hlslens
      },
      views = {
        cmdline_popup = {
          position = {
            row = "70%",
            col = "50%",
          },
          win_options = {
            winhighlight = {
              NormalFloat = "NoiceCmdlinePopupNormal",
              FloatBorder = "NoiceCmdlinePopupBorder",
            },
          },
        },
        cmdline_popupmenu = {
          win_options = {
            winhighlight = {
              NormalFloat = "NoiceCmdlinePopupmenuNormal",
              FloatBorder = "NoiceCmdlinePopupmenuBorder",
            },
          },
        },
      },
    },
  },

  -----------------------------------------------------------------------------------------
  -- textobj
  -----------------------------------------------------------------------------------------

  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },

  -- Bundle of two dozen new text objects for Neovim.
  -- https://github.com/chrisgrieser/nvim-various-textobjs
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    keys = {
      {
        "ae",
        "<Cmd>lua require('various-textobjs').entireBuffer()<CR>",
        mode = { "o", "x" },
        desc = "entire buffer",
      },
      {
        "ib",
        "<Cmd>lua require('various-textobjs').anyQuote('inner')<CR>",
        mode = { "o", "x" },
        desc = "inner any quote",
      },
      {
        "ab",
        "<Cmd>lua require('various-textobjs').anyQuote('outer')<CR>",
        mode = { "o", "x" },
        desc = "a any quote",
      },
      {
        "iu",
        '<cmd>lua require("various-textobjs").url()<CR>',
        mode = { "o", "x" },
        desc = "inner url",
      },
      {
        "il",
        '<cmd>lua require("various-textobjs").lineCharacterwise()<CR>',
        mode = { "o", "x" },
        desc = "inner line characterwise",
      },
    },
    opts = {
      useDefaults = false,
    },
  },

  -- Neovim plugin introducing a new operators motions to quickly replace and exchange text.
  -- https://github.com/gbprod/substitute.nvim
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    config = function()
      require("substitute").setup()

      -- keysで定義するとエラーが発生するため、ここで設定する
      vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
      vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
      vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
    end,
  },

  -- Region selection with hints on the AST nodes of a document powered by treesitter
  -- https://github.com/mfussenegger/nvim-treehopper
  {
    "mfussenegger/nvim-treehopper",
    keys = {
      {
        "m",
        function()
          require("tsht").nodes()
        end,
        mode = "o",
        desc = "Treehopper nodes",
        noremap = false,
        silent = true,
      },
      {
        "m",
        ":lua require('tsht').nodes()<CR>",
        mode = "x",
        desc = "Treehopper nodes",
        noremap = true,
        silent = true,
      },
    },
  },

  -- The set of operator and textobject plugins to search/select/edit sandwiched textobjects.
  -- https://github.com/machakann/vim-sandwich
  {
    "machakann/vim-sandwich",
    keys = { "sa", "sr" },
    init = function()
      vim.g.textobj_sandwich_no_default_key_mappings = 1
    end,
    config = function()
      vim.g["sandwich#recipes"] = vim.tbl_extend("force", vim.deepcopy(vim.g["sandwich#default_recipes"]), {
        {
          buns = { "${", "}" },
          input = { "$" },
          filetype = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
        {
          buns = { "#{", "}" },
          input = { "#" },
          filetype = { "ruby", "eruby" },
        },
        {
          buns = { "「", "」" },
          input = { "c" },
        },
        {
          buns = { "[[", "]]" },
          input = { "l" },
          filetype = { "markdown" },
        },
        {
          buns = { "[", "]()" },
          input = { "L" },
          filetype = { "markdown" },
        },
      })
    end,
  },

  -- https://github.com/kana/vim-niceblock
  {
    "kana/vim-niceblock",
    keys = { "v" },
  },

  -----------------------------------------------------------------------------------------
  -- Editing
  -----------------------------------------------------------------------------------------

  --  🧠 💪 // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
  -- https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    keys = { { "gc", "gcc", mode = { "n", "v" } } },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- This plugin trims trailing whitespace and lines.
  -- https://github.com/cappyzawa/trim.nvim
  {
    "cappyzawa/trim.nvim",
    cmd = { "TrimToggle", "Trim" },
    keys = {
      {
        "<Leader>tr",
        "<Cmd>Trim<CR>",
        desc = "Trim whitespace",
      },
    },
    opts = {
      trim_last_line = false,
      trim_first_line = false,
    },
  },

  -- https://github.com/mattn/vim-maketable
  {
    "mattn/vim-maketable",
    cmd = { "MakeTable" },
  },

  -- Use treesitter to auto close and auto rename html tag
  -- https://github.com/windwp/nvim-ts-autotag
  {
    "windwp/nvim-ts-autotag",
    lazy = true,
    opts = {},
  },

  -- enhanced increment/decrement plugin for Neovim.
  -- https://github.com/monaqa/dial.nvim
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<C-a>",
        "<Cmd>lua require('dial.map').manipulate('increment', 'normal')<CR>",
        mode = "n",
      },
      {
        "<C-x>",
        "<Cmd>lua require('dial.map').manipulate('decrement', 'normal')<CR>",
        mode = "n",
      },
      {
        "+",
        "<Cmd>lua require('dial.map').manipulate('increment', 'normal')<CR>",
        mode = "n",
      },
      {
        "-",
        "<Cmd>lua require('dial.map').manipulate('decrement', 'normal')<CR>",
        mode = "n",
      },
      {
        "<C-a>",
        "<Cmd>lua require('dial.map').manipulate('increment', 'visual')<CR>",
        mode = "v",
      },
      {
        "<C-x>",
        "<Cmd>lua require('dial.map').manipulate('decrement', 'visual')<CR>",
        mode = "v",
      },
      {
        "g<C-a>",
        "<Cmd>lua require('dial.map').manipulate('increment', 'gvisual')<CR>",
        mode = "v",
      },
      {
        "g<C-x>",
        "<Cmd>lua require('dial.map').manipulate('decrement', 'gvisual')<CR>",
        mode = "v",
      },
    },
    config = function()
      local augend = require("dial.augend")

      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.integer.alias.binary,
          augend.date.new({
            pattern = "%Y/%m/%d",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          }),
          augend.date.new({
            pattern = "%Y-%m-%d",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          }),
          augend.date.new({
            pattern = "%Y年%-m月%-d日",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          }),
          augend.date.new({
            pattern = "%-m月%-d日",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          }),
          augend.date.new({
            pattern = "%-m月%-d日(%J)",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          }),
          augend.date.new({
            pattern = "%-m月%-d日（%J）",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          }),
          augend.date.new({
            pattern = "%m/%d",
            default_kind = "day",
            only_valid = true,
            word = true,
            clamp = true,
            end_sensitive = true,
          }),
          augend.date.new({
            pattern = "%H:%M",
            default_kind = "min",
            only_valid = true,
            word = true,
          }),
          augend.constant.new({
            elements = { "true", "false" },
            word = true,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "True", "False" },
            word = true,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          }),
          augend.constant.alias.ja_weekday,
          augend.constant.alias.ja_weekday_full,
          augend.hexcolor.new({ case = "lower" }),
          augend.semver.alias.semver,
        },

        swift = {
          augend.constant.new({
            elements = { "XCTAssertTrue", "XCTAssertFalse" },
            word = true,
            cyclic = true,
          }),
          augend.constant.new({
            elements = { "XCTAssertNil", "XCTAssertNotNil" },
            word = true,
            cyclic = true,
          }),
        },
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "swift" },
        callback = function()
          vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal("swift"))
        end,
      })
    end,
  },

  -- Escape from insert mode without delay when typing
  -- https://github.com/max397574/better-escape.nvim
  {
    "max397574/better-escape.nvim",
    keys = { { "jj", mode = "i" } },
    opts = {
      timeout = vim.o.timeoutlen,
      default_mappings = false,
      mappings = {
        i = {
          j = {
            j = "<Esc>",
            k = "<Esc>",
          },
        },
        t = {
          j = {
            k = "<C-\\><C-n>",
          },
        },
      },
    },
  },

  -----------------------------------------------------------------------------------------
  -- Moving Cursor
  -----------------------------------------------------------------------------------------

  -- Extended f, F, t and T key mappings for Vim.
  -- https://github.com/rhysd/clever-f.vim
  {
    "rhysd/clever-f.vim",
    event = "BufReadPost",
    init = function()
      vim.g.clever_f_show_prompt = 1
      vim.g.clever_f_use_migemo = 0
      vim.g.clever_f_across_no_line = 1
    end,
  },

  -- https://github.com/yuki-yano/fuzzy-motion.vim
  {
    "yuki-yano/fuzzy-motion.vim",
    event = "VeryLazy",
    dependencies = {
      { "vim-denops/denops.vim" },
      { "lambdalisue/kensaku.vim" },
    },
    init = function()
      vim.g.fuzzy_motion_matchers = { "kensaku", "fzf" }

      vim.keymap.set({ "n", "x" }, "<Space><Space>", "<Cmd>FuzzyMotion<CR>")
      vim.keymap.set({ "n", "x" }, "sl", "<Cmd>FuzzyMotion<CR>")
    end,
  },

  -- 🔍 Search Japanese text in Vim's buffer with Roma-ji by Migemo
  -- https://github.com/lambdalisue/kensaku.vim
  {
    "lambdalisue/kensaku.vim",
    dependencies = {
      { "vim-denops/denops.vim" },
    },
  },

  -- Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
  -- https://github.com/zbirenbaum/copilot.lua
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = "InsertEnter",
    dependencies = {
      { "zbirenbaum/copilot-cmp" },
    },
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        todo = true,
        markdown = true,
        yaml = true,
        gitcommit = true,
      },
    },
  },

  -- Flexible key mapping manager.
  -- https://github.com/hrsh7th/nvim-insx
  {
    "hrsh7th/nvim-insx",
    event = "InsertEnter",
    config = function()
      local insx = require("insx")
      local esc = require("insx.helper.regex").esc
      local fast_wrap = require("insx.recipe.fast_wrap")
      local fast_break = require("insx.recipe.fast_break")
      local helper = require("insx.helper")

      local endwise = require("insx.recipe.endwise")
      insx.add("<CR>", endwise(endwise.builtin))

      -- quotes
      for _, quote in ipairs({ '"', "'" }) do
        -- jump_out
        insx.add(
          quote,
          require("insx.recipe.jump_next")({
            jump_pat = {
              [[\\\@<!\%#]] .. esc(quote) .. [[\zs]],
            },
          })
        )

        -- auto_pair
        insx.add(
          quote,
          insx.with(
            require("insx.recipe.auto_pair").strings({
              open = quote,
              close = quote,
              ignore_pat = [[\%#\w]],
            }),
            {
              {
                enabled = function(enabled, ctx)
                  return enabled(ctx) and not insx.helper.syntax.in_string_or_comment()
                end,
              },
            }
          )
        )

        -- delete_pair
        insx.add(
          "<BS>",
          require("insx.recipe.delete_pair").strings({
            open_pat = esc(quote),
            close_pat = esc(quote),
            ignore_pat = ([[\\%s\%%#]]):format(esc(quote)),
          })
        )
      end

      -- pairs
      for open, close in pairs({
        ["("] = ")",
        ["["] = "]",
        ["{"] = "}",
      }) do
        -- jump_out
        insx.add(
          close,
          require("insx.recipe.jump_next")({
            jump_pat = {
              [[\%#]] .. esc(close) .. [[\zs]],
            },
          })
        )

        -- auto_pair
        insx.add(
          open,
          insx.with(
            require("insx.recipe.auto_pair")({
              open = open,
              close = close,
            }),
            {
              insx.with.in_string(false),
              insx.with.in_comment(false),
              insx.with.nomatch([[\%#\w]]),
              insx.with.undopoint(),
            }
          )
        )

        -- delete_pair
        insx.add(
          "<BS>",
          require("insx.recipe.delete_pair")({
            open_pat = esc(open),
            close_pat = esc(close),
          })
        )

        -- spacing
        insx.add(
          "<Space>",
          require("insx.recipe.pair_spacing").increase({
            open_pat = esc(open),
            close_pat = esc(close),
          })
        )
        insx.add(
          "<BS>",
          require("insx.recipe.pair_spacing").decrease({
            open_pat = esc(open),
            close_pat = esc(close),
          })
        )

        -- fast_break
        insx.add(
          "<CR>",
          require("insx.recipe.fast_break")({
            open_pat = esc(open),
            close_pat = esc(close),
            html_attrs = true,
            arguments = true,
          })
        )

        -- fast_wrap
        insx.add(
          "<C-]>",
          require("insx.recipe.fast_wrap")({
            close = close,
          })
        )
      end
    end,
  },

  {
    "Bakudankun/BackAndForward.vim",
    keys = {
      { "<C-o>", "<Plug>(backandforward-back)", mode = "n", desc = "Back" },
      { "<C-i>", "<Plug>(backandforward-forward)", mode = "n", desc = "Forward" },
    },
    init = function()
      vim.g.backandforward_config = {
        define_commands = false,
      }
    end,
  },

  --------------------------------------------------------------------------------
  -- File Management
  --------------------------------------------------------------------------------

  -- Open alternative files for the current buffer
  -- https://github.com/rgroli/other.nvim
  {
    "rgroli/other.nvim",
    cmd = { "Other" },
    opts = {
      mappings = {
        {
          pattern = "/lib/(.*)/(.*).rb",
          target = {
            { target = "/spec/%1/%2_spec.rb", context = "spec" },
          },
        },
        {
          pattern = "/(.*).rb",
          target = {
            target = "/sig/%1.rbs",
            context = "sig",
          },
        },
        {
          pattern = "/sig/(.*).rbs",
          target = {
            target = "/%1.rb",
            context = "sig",
          },
        },
      },
    },
  },

  -- Neovim file explorer: edit your filesystem like a buffer
  -- https://github.com/stevearc/oil.nvim
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      view_optios = {
        show_hidden = true,
      },
      columns = {
        "icon",
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 120,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "right",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
      keymaps = {
        ["<BS>"] = { "actions.parent", mode = "n" },
        ["<C-p>"] = { "actions.preview", mode = "n" },
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
      { "<C-n>", ":lua require('oil').toggle_float()<CR>", { noremap = true, expr = false, silent = true } },
    },
  },

  --------------------------------------------------------------------------------
  -- Window
  --------------------------------------------------------------------------------

  -- Make your nvim window separators colorful
  -- https://github.com/nvim-zh/colorful-winsep.nvim
  {
    "nvim-zh/colorful-winsep.nvim",
    event = "BufReadPost",
    opt = {},
  },

  -- 🧠 Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of "up/down/left/right".
  -- https://github.com/mrjones2014/smart-splits.nvim
  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      {
        "<S-Left>",
        ":lua require('smart-splits').resize_left()<CR>",
        silent = true,
      },
      {
        "<S-Down>",
        ":lua require('smart-splits').resize_down()<CR>",
        silent = true,
      },
      {
        "<S-Up>",
        ":lua require('smart-splits').resize_up()<CR>",
        silent = true,
      },
      {
        "<S-Right>",
        ":lua require('smart-splits').resize_right()<CR>",
        silent = true,
      },
    },
    lazy = true,
  },

  -----------------------------------------------------------------------------------------
  -- Utility
  -----------------------------------------------------------------------------------------

  -- Open URI with your favorite browser from your most favorite editor
  -- https://github.com/tyru/open-browser.vim
  {
    "tyru/open-browser.vim",
    keys = {
      {
        "gx",
        "<Plug>(openbrowser-smart-search)",
        mode = { "n", "v" },
        remap = true,
      },
    },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw's gx mapping.
    end,
  },

  -- Open GitHub URL of current file, etc. from Vim editor (supported GitHub Enterprise)
  -- https://github.com/tyru/open-browser-github.vim
  {
    "tyru/open-browser-github.vim",
    lazy = true,
    dependencies = {
      "tyru/open-browser.vim",
    },
    cmd = { "OpenGithubFile", "OpenGithubIssue", "OpenGithubPullReq", "OpenGithubProject" },
  },

  -- tmux integration for nvim features pane movement and resizing from within nvim.
  -- https://github.com/aserowy/tmux.nvim
  {
    "aserowy/tmux.nvim",
    keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
    lazy = true,
    opts = {
      {
        copy_sync = {
          enable = false,
          sync_registers = false,
        },
      },
    },
  },

  -- A vim plugin to perform diffs on blocks of code
  -- https://github.com/AndrewRadev/linediff.vim
  {
    "AndrewRadev/linediff.vim",
    cmd = { "Linediff" },
  },

  -- Efficient Todo.txt management in vim
  -- https://github.com/pupepa/todo.txt-vim
  {
    "pupepa/todo.txt-vim",
    ft = "todo",
    branch = "weekday-recurrence-support",
    init = function()
      vim.g.Todo_txt_do_not_map = 1
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "todo",
        callback = function()
          vim.opt_local.omnifunc = "todo#Complete"
          vim.opt_local.completeopt:remove("preview")
        end,
      })
    end,
  },

  -- Control Xcode from Vim
  -- https://github.com/pupepa/vim-xcode-control
  {
    "pupepa/vim-xcode-control",
    ft = { "swift", "objc" },
    keys = {
      {
        "<Leader>xb",
        "<Plug>(xcode_control_build)",
        desc = "Xcode Build",
        silent = true,
      },
      {
        "<Leader>xr",
        "<Plug>(xcode_control_run)",
        desc = "Xcode Build and Run",
        silent = true,
      },
      {
        "<Leader>xc",
        "<Plug>(xcode_control_clean)",
        desc = "Xcode Clean",
        silent = true,
      },
      {
        "<Leader>xv",
        "<Plug>(xcode_control_refresh_canvas)",
        desc = "Xcode Refresh Canvas",
        silent = true,
      },
    },
  },

  -- simple memo plugin for Vim.
  -- https://github.com/glidenote/memolist.vim
  {
    "glidenote/memolist.vim",
    cmd = { "MemoNew", "MemoList", "MemoGrep" },
    keys = {
      { "<Leader>mn", "<cmd>MemoNew<CR>", desc = "New memo" },
    },
    init = function()
      vim.g.memolist_path = "$HOME/Documents/memolist"
      vim.g.memolist_memo_suffix = "md"
      vim.g.memolist_denite = 0
    end,
  },

  -- Rainbow CSV - Vim plugin: Highlight columns in CSV and TSV files and build queries in SQL-like language
  -- https://github.com/mechatroner/rainbow_csv
  {
    "mechatroner/rainbow_csv",
    ft = "csv",
  },

  -- Vim plugin for the Perl module / CLI script 'ack'
  -- https://github.com/mileszs/ack.vim
  {
    "mileszs/ack.vim",
    cmd = "Ack",
    init = function()
      if vim.fn.executable("rg") == 1 then
        vim.g.ackprg = "rg --vimgrep"
      end
    end,
  },

  -- Realtime preview by Vim. (Markdown, reStructuredText, textile)
  -- https://github.com/previm/previm
  {
    "previm/previm",
    ft = { "markdown", "asciidoc" },
    dependencies = {
      "tyru/open-browser.vim",
    },
  },

  -- 📑 Delete multiple vim buffers based on different conditions
  -- https://github.com/kazhala/close-buffers.nvim
  {
    "kazhala/close-buffers.nvim",
    keys = {
      {
        "<leader>bo",
        ":lua require('close_buffers').delete({ type = 'other', force = true })<cr>",
        desc = "close other",
        silent = true,
      },
      {
        "<leader>bd",
        ":lua require('close_buffers').delete({ type = 'this', force = true })<cr>",
        desc = "close",
        silent = true,
      },
      {
        "<leader>bD",
        ":lua require('close_buffers').delete({ type = 'all', force = true })<cr>",
        desc = "close all",
        silent = true,
      },
    },
  },

  -- Perform the replacement in quickfix.
  -- https://github.com/thinca/vim-qfreplace
  {
    "thinca/vim-qfreplace",
    cmd = { "Qfreplace" },
  },

  -- Run commands quickly.
  -- https://github.com/thinca/vim-quickrun
  {
    "thinca/vim-quickrun",
    cmd = { "QuickRun" },
    init = function()
      vim.g.quickrun_config = {
        _ = {
          runner = "system",
        },
        markdown = {
          outputter = "null",
          command = "open",
          cmdopt = "-a",
          args = "/Applications/Google\\ Chrome.app",
          exec = "%c %o %a %s",
        },
        ["ruby.bundle"] = {
          command = "ruby",
          cmdopt = "bundle exec",
          exec = "%o %c %s",
        },
        ["markdown.marp"] = {
          command = "marp",
          cmdopt = "--theme-set ./marp-themes/test.css -p",
          runner = "terminal",
          exec = "%c %o %s",
        },
      }
    end,
  },

  -- A plugin for profiling Vim and Neovim startup time.
  -- https://github.com/dstein64/vim-startuptime
  {
    "dstein64/vim-startuptime",
    cmd = { "StartupTime" },
    init = function()
      vim.g.startuptime_event_width = 100
    end,
  },

  -- A neovim lua plugin to help easily manage multiple terminal windows
  -- https://github.com/akinsho/toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm" },
    keys = { "<Leader>tg", "<Leader>tf", "<Leader>tt" },
    config = function()
      require("toggleterm").setup({
        -- size can be a number or function which is passed the current terminal
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.40
          end
        end,
        on_open = function()
          -- Prevent infinite calls from freezing neovim.
          -- Only set these options specific to this terminal buffer.
          vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
          vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
        end,
        open_mapping = false, -- [[<c-\>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = false,
        shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
      })

      local Terminal = require("toggleterm.terminal").Terminal

      local tig = Terminal:new({ cmd = "tig", hidden = true, direction = "float" })

      function _tig_toggle()
        tig:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _tig_toggle()<CR>", { noremap = true, silent = true })

      local trf = Terminal:new({ cmd = "trf", hidden = true, direction = "float" })

      function _trf_toggle()
        trf:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua _trf_toggle()<CR>", { noremap = true, silent = true })

      vim.keymap.set("n", "<Leader>tt", ":ToggleTerm size=30<CR>")
    end,
  },

  -- Vim syntax for Re:VIEW
  -- https://github.com/tokorom/vim-review
  {
    "tokorom/vim-review",
    ft = "review",
    init = function()
      vim.g["vim_review#include_filetypes"] = { "swift", "ruby", "json", "yaml" }
    end,
  },

  -- ✍️ All the npm/yarn/pnpm commands I don't want to type
  -- https://github.com/vuki656/package-info.nvim
  {
    "vuki656/package-info.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- A plugin to visualise and resolve merge conflicts in neovim
  -- https://github.com/akinsho/git-conflict.nvim
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },

  -- cd project root automatically
  -- https://github.com/wsdjeg/rooter.nvim
  {
    "wsdjeg/rooter.nvim",
    opts = {
      root_patterns = { "node_modules/", "Gemfile", "package.json", ".git/" },
      outermost = false,
    },
    dependencies = {
      {
        "wsdjeg/logger.nvim",
        config = function()
          vim.keymap.set("n", "<leader>hL", '<cmd>lua require("logger").viewRuntimeLog()<cr>', { silent = true })
        end,
      },
    },
  },

  --A fully-featured 🤏 HTTP-client 🐼 interface 🖥️ for Neovim ❤️.
  -- https://github.com/mistweaverco/kulala.nvim
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      kulala_keymaps_prefix = "",
      global_keymaps = {
        ["Send request"] = {
          "<leader>Rs",
          function()
            require("kulala").run()
          end,
          mode = { "n", "v" },
          desc = "Send request",
        },
        ["Send all requests"] = {
          "<leader>Ra",
          function()
            require("kulala").run_all()
          end,
          mode = { "n", "v" },
          ft = { "http", "rest" },
        },
      },
    },
  },
})
