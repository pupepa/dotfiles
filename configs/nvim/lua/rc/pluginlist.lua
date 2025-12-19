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
  {
    "kkharji/sqlite.lua",
    lazy = true,
  },

  -- UI Component Library for Neovim.
  -- https://github.com/MunifTanjim/nui.nvim
  { "MunifTanjim/nui.nvim", lazy = true },

  -- Better quickfix window in Neovim, polish old quickfix window.
  -- https://github.com/kevinhwang91/nvim-bqf
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

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
      require("rc/pluginconfig/mason")
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
      require("rc/pluginconfig/null-ls")
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
    config = function()
      require("rc/pluginconfig/nvim-cmp")
    end,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0,
      })
    end,
  },

  -- vscode-like pictograms for neovim lsp completion items
  -- https://github.com/onsails/lspkind.nvim
  {
    "onsails/lspkind-nvim",
    lazy = true,
    config = function()
      require("rc/pluginconfig/lspkind-nvim")
    end,
  },

  {
    "dcampos/cmp-snippy",
    lazy = true,
    dependencies = {
      "dcampos/nvim-snippy",
    },
  },

  -- nvim-cmp source for neovim builtin LSP client
  -- https://github.com/hrsh7th/cmp-nvim-lsp
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },

  -- nippet plugin for Neovim
  -- https://github.com/dcampos/nvim-snippy
  {
    "dcampos/nvim-snippy",
    lazy = true,
    config = function()
      require("rc/pluginconfig/nvim-snippy")
    end,
  },

  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
  -- https://github.com/williamboman/mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("rc/pluginconfig/mason-lspconfig")
    end,
  },

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
    event = "BufRead",
    dependencies = {
      "glepnir/lspsaga.nvim",
      "nvim-lualine/lualine.nvim",
    },
  },

  -- neovim lsp plugin
  -- https://github.com/glepnir/lspsaga.nvim
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-lualine/lualine.nvim",
    },
    config = function()
      require("rc/pluginconfig/lspsaga")
    end,
  },

  -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = function()
      require("rc/pluginconfig/trouble")
    end,
  },

  -- Standalone UI for nvim-lsp progress
  -- https://github.com/j-hui/fidget.nvim
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
      require("rc/pluginconfig/fidget")
    end,
  },

  -- https://github.com/hrsh7th/nvim-gtd
  -- LSP's Go to definition plugin for neovim.
  {
    "hrsh7th/nvim-gtd",
    keys = { "gf", "gfv", "gfs" },
    config = function()
      require("rc/pluginconfig/nvim-gtd")
    end,
  },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    lazy = true,
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },

  -- https://github.com/zbirenbaum/copilot-cmp
  {
    "zbirenbaum/copilot-cmp",
    lazy = true,
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -----------------------------------------------------------------------------------------
  -- Treesitter
  -----------------------------------------------------------------------------------------

  -- Nvim Treesitter configurations and abstraction layer
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "BufReadPost",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("rc/pluginconfig/nvim-treesitter")
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
    version = "0.1.8",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("rc/pluginconfig/telescope")
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
      require("rc/pluginconfig/nightfox")
    end,
  },

  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = { "EdenEast/nightfox.nvim" },
    config = function()
      require("rc/pluginconfig/lualine")
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
    config = function()
      require("rc/pluginconfig/bufferline")
    end,
  },

  --URL highlight everywhere
  -- https://github.com/itchyny/vim-highlighturl
  {
    "itchyny/vim-highlighturl",
    event = "BufEnter",

    config = function()
      require("rc/pluginconfig/vim-highlighturl")
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
          vim.cmd("normal! " .. vim.v.count1 .. "n")
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
          vim.cmd("normal! " .. vim.v.count1 .. "N")
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
        vim.cmd('noau normal! "vy')
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
    config = function()
      require("rc/pluginconfig/gitsigns")
    end,
  },

  -- Indent guides for Neovim
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    tag = "v2.20.8",
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/indent-blankline")
    end,
  },

  -- illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
  -- https://github.com/RRethy/vim-illuminate
  {
    "RRethy/vim-illuminate",
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/vim-illuminate")
    end,
  },

  -- A fancy, configurable, notification manager for NeoVim
  -- https://github.com/rcarriga/nvim-notify
  {
    "rcarriga/nvim-notify",
    event = "BufreadPre",
    config = function()
      require("rc/pluginconfig/nvim-notify")
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
    config = function()
      require("rc/pluginconfig/nvim_context_vt")
    end,
  },

  -- Git Blame plugin for Neovim written in Lua
  -- https://github.com/f-person/git-blame.nvim
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = false, -- if you want to enable the plugin
      message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
      date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },
  },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  -- https://github.com/folke/noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
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
    config = function()
      require("rc/pluginconfig/nvim-various-textobjs")
    end,
  },

  -- Neovim plugin introducing a new operators motions to quickly replace and exchange text.
  -- https://github.com/gbprod/substitute.nvim
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/substitute")
    end,
  },

  -- Region selection with hints on the AST nodes of a document powered by treesitter
  -- https://github.com/mfussenegger/nvim-treehopper
  {
    "mfussenegger/nvim-treehopper",
    event = "VeryLazy",
    config = function()
      vim.keymap.set({ "o" }, "m", function()
        require("tsht").nodes()
      end, { noremap = false, expr = false, silent = true })

      vim.keymap.set({ "x" }, "m", ":lua require('tsht').nodes()<CR>", { noremap = true, expr = false, silent = true })
    end,
  },

  -- The set of operator and textobject plugins to search/select/edit sandwiched textobjects.
  -- https://github.com/machakann/vim-sandwich
  {
    "machakann/vim-sandwich",
    lazy = true,
    keys = { "sa", "sr" },
    config = function()
      require("rc/pluginconfig/vim-sandwich")
    end,
  },

  -- https://github.com/kana/vim-niceblock
  {
    "kana/vim-niceblock",
    lazy = true,
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
    keys = { "<Leader>tr" },
    config = function()
      require("rc/pluginconfig/trim")
    end,
  },

  -- https://github.com/mattn/vim-maketable
  {
    "mattn/vim-maketable",
    cmd = { "MakeTable" },
  },

  -- Edits part of buffer by another buffer.
  -- https://github.com/thinca/vim-partedit
  {
    "thinca/vim-partedit",
    cmd = { "PartEdit", "ParteditEnd", "MyParteditContext" },
    config = function()
      require("rc/pluginconfig/vim-partedit")
    end,
  },

  -- Use treesitter to auto close and auto rename html tag
  -- https://github.com/windwp/nvim-ts-autotag
  {
    "windwp/nvim-ts-autotag",
    lazy = true,
    config = function()
      require("rc/pluginconfig/nvim-ts-autotag")
    end,
  },

  -- enhanced increment/decrement plugin for Neovim.
  -- https://github.com/monaqa/dial.nvim
  {
    "monaqa/dial.nvim",
    lazy = true,
    keys = { "<C-a>", "<C-x>", "+", "-" },
    config = function()
      require("rc/pluginconfig/dial")
    end,
  },

  -- Escape from insert mode without delay when typing
  -- https://github.com/max397574/better-escape.nvim
  {
    "max397574/better-escape.nvim",
    lazy = true,
    keys = { { "jj", mode = "i" } },
    config = function()
      require("rc/pluginconfig/better-escape")
    end,
  },

  -----------------------------------------------------------------------------------------
  -- Moving Cursor
  -----------------------------------------------------------------------------------------

  -- Extended f, F, t and T key mappings for Vim.
  -- https://github.com/rhysd/clever-f.vim
  {
    "rhysd/clever-f.vim",
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/clever-f")
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
    config = function()
      require("rc/pluginconfig/copilot")
    end,
  },

  -- Flexible key mapping manager.
  -- https://github.com/hrsh7th/nvim-insx
  {
    "hrsh7th/nvim-insx",
    event = "InsertEnter",
    config = function()
      require("rc/pluginconfig/nvim-insx")
    end,
  },

  --------------------------------------------------------------------------------
  -- File Management
  --------------------------------------------------------------------------------

  -- Open alternative files for the current buffer
  -- https://github.com/rgroli/other.nvim
  {
    "rgroli/other.nvim",
    lazy = true,
    cmd = { "Other" },
    config = function()
      require("rc/pluginconfig/other")
    end,
  },

  -- Neovim file explorer
  -- https://github.com/tamago324/lir.nvim
  -- {
  --   "tamago324/lir.nvim",
  --   keys = { "<C-n>" },
  --   dependencies = {
  --     "tamago324/lir-git-status.nvim",
  --   },
  --   config = function()
  --     require("rc/pluginconfig/lir")
  --   end,
  -- },
  --
  -- -- Git status integration of lir.nvim
  -- -- https://github.com/tamago324/lir-git-status.nvim
  -- {
  --   "tamago324/lir-git-status.nvim",
  --   lazy = true,
  -- },

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

  -- Automatically expand width of the current window. Maximizes and restore it. And all this with nice animations!
  -- https://github.com/anuvyklack/windows.nvim
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      "anuvyklack/middleclass",
    },
    config = function()
      require("rc/pluginconfig/windows")
    end,
  },

  -- Make your nvim window separators colorful
  -- https://github.com/nvim-zh/colorful-winsep.nvim
  {
    "nvim-zh/colorful-winsep.nvim",
    event = "BufRead",
    config = function()
      require("colorful-winsep").setup()
    end,
  },

  -- 🧠 Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of "up/down/left/right".
  -- https://github.com/mrjones2014/smart-splits.nvim
  {
    "mrjones2014/smart-splits.nvim",
    keys = { "<S-Left>", "<S-Down>", "<S-Up>", "<S-Right>" },
    lazy = true,
    init = function()
      vim.keymap.set("n", "<S-Left>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<S-Down>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<S-Up>", require("smart-splits").resize_up)
      vim.keymap.set("n", "<S-Right>", require("smart-splits").resize_right)
    end,
  },

  -----------------------------------------------------------------------------------------
  -- Utility
  -----------------------------------------------------------------------------------------

  -- Open URI with your favorite browser from your most favorite editor
  -- https://github.com/tyru/open-browser.vim
  {
    "tyru/open-browser.vim",
    keys = { "gx" },
    config = function()
      require("rc/pluginconfig/open-browser")
    end,
  },

  -- Open GitHub URL of current file, etc. from Vim editor (supported GitHub Enterprise)
  -- https://github.com/tyru/open-browser-github.vim
  {
    "tyru/open-browser-github.vim",
    lazy = true,
    cmd = { "OpenGithubFile", "OpenGithubIssue", "OpenGithubPullReq", "OpenGithubProject" },
  },

  {
    "aserowy/tmux.nvim",
    keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
    config = function()
      require("rc/pluginconfig/tmux")
    end,
  },

  -- A vim plugin to perform diffs on blocks of code
  -- https://github.com/AndrewRadev/linediff.vim
  {
    "AndrewRadev/linediff.vim",
    lazy = true,
    cmd = { "Linediff" },
  },

  -- Efficient Todo.txt management in vim
  -- https://github.com/pupepa/todo.txt-vim
  {
    "pupepa/todo.txt-vim",
    ft = { "todo" },
    branch = "weekday-recurrence-support",
    config = function()
      require("rc/pluginconfig/todo_txt-vim")
    end,
  },

  -- Control Xcode from Vim
  -- https://github.com/pupepa/vim-xcode-control
  {
    "pupepa/vim-xcode-control",
    ft = { "swift", "objc" },
    config = function()
      require("rc/pluginconfig/vim-xcode-control")
    end,
  },

  -- simple memo plugin for Vim.
  -- https://github.com/glidenote/memolist.vim
  {
    "glidenote/memolist.vim",
    cmd = { "MemoNew", "MemoList", "MemoGrep" },
    config = function()
      require("rc/pluginconfig/memolist")
    end,
  },

  -- build your tests at the speed of thought
  -- https://github.com/janko/vim-test
  {
    "janko-m/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = function()
      require("rc/pluginconfig/vim-test")
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
    config = function()
      require("rc/pluginconfig/ack")
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

  -- Delete Neovim buffers without losing window layout
  -- -- https://github.com/famiu/bufdelete.nvim
  -- {
  --   "famiu/bufdelete.nvim",
  --   keys = { "<Leader>bd", "<Leader>bdd" },
  --   config = function()
  --     require("rc/pluginconfig/bufdelete")
  --   end,
  -- },

  {
    "kazhala/close-buffers.nvim",
    lazy = true,
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

  -- Vim plugin for generating images of source code using https://github.com/Aloxaf/silicon
  -- https://github.com/segeljakt/vim-silicon
  {
    "segeljakt/vim-silicon",
    cmd = { "Silicon" },
    config = function()
      require("rc/pluginconfig/vim-silicon")
    end,
  },

  -- Ctags generator for Vim
  -- https://github.com/szw/vim-tags
  {
    "szw/vim-tags",
    cmd = { "TagsGenerate" },
    config = function()
      require("rc/pluginconfig/vim-tags")
    end,
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
    config = function()
      require("rc/pluginconfig/vim-quickrun")
    end,
  },

  -- Integrated reference viewer.
  -- https://github.com/thinca/vim-ref
  {
    "thinca/vim-ref",
    cmd = { "Ref" },
    config = function()
      require("rc/pluginconfig/vim-ref")
    end,
  },

  -- Show Ex command output in buffer
  -- https://github.com/tyru/capture.vim
  {
    "tyru/capture.vim",
    cmd = { "Capture" },
  },

  -- A plugin for profiling Vim and Neovim startup time.
  -- https://github.com/dstein64/vim-startuptime
  {
    "dstein64/vim-startuptime",
    cmd = { "StartupTime" },
    config = function()
      require("rc/pluginconfig/vim-startuptime")
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
      require("rc/pluginconfig/toggleterm")
    end,
  },

  {
    "chomosuke/term-edit.nvim",
    version = "1.*",
    ft = "toggleterm",
    config = function()
      require("rc/pluginconfig/term-edit")
    end,
  },

  -- Vim syntax for Re:VIEW
  -- https://github.com/tokorom/vim-review
  {
    "tokorom/vim-review",
    ft = "review",
    config = function()
      require("rc/pluginconfig/vim-review")
    end,
  },

  -- ✍️ All the npm/yarn/pnpm commands I don't want to type
  -- https://github.com/vuki656/package-info.nvim
  {
    "vuki656/package-info.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/package-info")
    end,
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
    config = function()
      require("rooter").setup({
        root_patterns = { "node_modules/", "Gemfile", "package.json", ".git/" },
        outermost = false,
      })
    end,
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
