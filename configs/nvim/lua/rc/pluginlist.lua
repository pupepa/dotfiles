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
  { "nvim-lua/popup.nvim",  module = "popup" },

  -- All the lua functions I don't want to write twice.
  -- https://github.com/nvim-lua/plenary.nvim
  { "nvim-lua/plenary.nvim" }, -- do not lazy load

  -- SQLite LuaJIT binding with a very simple api.
  -- https://github.com/kkharji/sqlite.lua
  { "kkharji/sqlite.lua",   module = "sqlite" },

  -- UI Component Library for Neovim.
  -- https://github.com/MunifTanjim/nui.nvim
  { "MunifTanjim/nui.nvim", module = "nui" },

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
      "jose-elias-alvarez/null-ls.nvim",
      -- https://github.com/jay-babu/mason-null-ls.nvim
      {
        "jayp0521/mason-null-ls.nvim",
        config = function()
          require("mason-null-ls").setup()
        end,
      },
      "j-hui/fidget.nvim",
    },
    event = "BufReadPre",
    config = function()
      require("rc/pluginconfig/mason")
    end,
  },

  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  -- https://github.com/jose-elias-alvarez/null-ls.nvim
  {
    "jose-elias-alvarez/null-ls.nvim",
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

      "windwp/nvim-autopairs",
    },
    config = function()
      require("rc/pluginconfig/nvim-cmp")
    end,
  },

  -- vscode-like pictograms for neovim lsp completion items
  -- https://github.com/onsails/lspkind.nvim
  {
    "onsails/lspkind-nvim",
    module = "lspkind",
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
  { "hrsh7th/cmp-nvim-lsp",               module = "cmp_nvim_lsp" },

  -- nippet plugin for Neovim
  -- https://github.com/dcampos/nvim-snippy
  {
    "dcampos/nvim-snippy",
    lazy = true,
    config = function()
      require("rc/pluginconfig/nvim-snippy")
    end,
  },

  -- nvim-cmp comparator function for completion items that start with one or more underlines
  -- https://github.com/lukas-reineke/cmp-under-comparator
  { "lukas-reineke/cmp-under-comparator", module = "cmp-under-comparator" },

  -- autopairs for neovim written by lua
  -- https://github.com/windwp/nvim-autopairs
  {
    "windwp/nvim-autopairs",
    lazy = true,
    config = function()
      require("rc/pluginconfig/nvim-autopairs")
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

  -- Quickstart configs for Nvim LSP
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    opt = false,
    dependencies = {
      "glepnir/lspsaga.nvim",

      "nvim-lualine/lualine.nvim",
    },
    config = function()
      require("rc/pluginconfig/nvim-lspconfig")
    end,
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
    opt = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = function()
      require("rc/pluginconfig/trouble")
    end,
  },

  -- Standalone UI for nvim-lsp progress
  -- https://github.com/j-hui/fidget.nvim
  {
    "j-hui/fidget.nvim",
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

  -----------------------------------------------------------------------------------------
  -- Treesitter
  -----------------------------------------------------------------------------------------

  -- Nvim Treesitter configurations and abstraction layer
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opt = true,
    event = "BufReadPost",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("rc/pluginconfig/nvim-treesitter")
    end,
  },

  -----------------------------------------------------------------------------------------
  -- Fuzzy Finder
  -----------------------------------------------------------------------------------------

  -- Find, Filter, Preview, Pick. All lua, all the time.
  -- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.1",
    event = { "VimEnter" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "neanias/telescope-lines.nvim",
      "neanias/telescope-lines.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ghq.nvim",
      "nvim-telescope/telescope-github.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require("rc/pluginconfig/telescope")
    end,
  },

  -- A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history.
  -- https://github.com/nvim-telescope/telescope-frecency.nvim
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = { "kkharji/sqlite.lua" },
  },

  {
    "neanias/telescope-lines.nvim",
    lazy = true,
  },

  -- File Browser extension for telescope.nvim
  -- https://github.com/nvim-telescope/telescope-file-browser.nvim
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
  },

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
    dependencies = { "EdenEast/nightfox.nvim" },
    config = function()
      require("rc/pluginconfig/lualine")
    end,
  },

  -- A snazzy bufferline for Neovim
  -- https://github.com/akinsho/bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    version = "v2.*",
    event = "BufReadPost",
    opt = true,
    dependencies = "kyazdani42/nvim-web-devicons",
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
    config = function()
      require("rc/pluginconfig/nvim-hlslens")
    end,
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
    opt = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/indent-blankline")
    end,
  },

  -- Extensible Neovim Scrollbar
  -- https://github.com/petertriho/nvim-scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost" },
    config = function()
      require("rc/pluginconfig/nvim-scrollbar")
    end,
  },

  -- Neovim plugin to preview the contents of the registers
  -- https://github.com/tversteeg/registers.nvim
  {
    "tversteeg/registers.nvim",
    keys = { { '"', mode = "n" }, { "<C-r", mode = "i" } },
    branch = "main",
    config = function()
      require("rc/pluginconfig/registers")
    end,
  },

  -- Neovim plugin for a code outline window
  -- https://github.com/stevearc/aerial.nvim
  {
    "stevearc/aerial.nvim",
    keys = { "<Leader>ae", "<Leader>af" },
    config = function()
      require("rc/pluginconfig/aerial")
    end,
  },

  -- illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
  -- https://github.com/RRethy/vim-illuminate
  {
    "RRethy/vim-illuminate",
    opt = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/vim-illuminate")
    end,
  },

  {
    "rcarriga/nvim-notify",
    event = "BufreadPre",
    config = function()
      require("rc/pluginconfig/nvim-notify")
    end,
  },

  -----------------------------------------------------------------------------------------
  -- textobj
  -----------------------------------------------------------------------------------------

  -- Vim plugin: Create your own text objects
  -- https://github.com/kana/vim-textobj-user
  {
    "kana/vim-textobj-user",
    opt = true,
    keys = { "y", "c", "d", "v" },
    dependencies = {
      -- Vim plugin: Text objects for entire buffer
      -- https://github.com/kana/vim-textobj-entire
      { "kana/vim-textobj-entire",            opt = true },

      -- Vim plugin: Text objects for the current line
      -- https://github.com/kana/vim-textobj-line
      { "kana/vim-textobj-line",              opt = true },

      -- https://github.com/kana/vim-textobj-indent
      { "kana/vim-textobj-indent",            opt = true },

      -- The vim textobject plugin to treat function-call regions.
      -- https://github.com/machakann/vim-textobj-functioncall
      { "machakann/vim-textobj-functioncall", opt = true },

      -- https://github.com/mattn/vim-textobj-url
      { "mattn/vim-textobj-url",              opt = true },

      -- https://github.com/osyo-manga/vim-textobj-multiblock
      {
        "osyo-manga/vim-textobj-multiblock",
        opt = true,
        config = function()
          require("rc/pluginconfig/vim-textobj-multiblock")
        end,
      },

      -- https://github.com/pocke/vim-textobj-markdown
      { "pocke/vim-textobj-markdown",          opt = true },

      -- A fork of textobj-parameter 0.1.0
      -- https://github.com/sgur/vim-textobj-parameter
      { "sgur/vim-textobj-parameter",          opt = true },

      -- A text object to turn foo_bar_baz into foo_baz *and* quuxSpamEggs into quuxEggs *and* shine your shoes
      -- https://github.com/Julian/vim-textobj-variable-segment
      { "julian/vim-textobj-variable-segment", opt = true },

      -- Vim plugin: Text objects for date and time
      -- https://github.com/kana/vim-textobj-datetime
      { "kana/vim-textobj-datetime",           opt = true },
    },
  },

  -- Vim plugin: Operator to replace text with register content
  -- https://github.com/yuki-yano/vim-operator-replace
  {
    "yuki-yano/vim-operator-replace",
    dependencies = "kana/vim-operator-user",
    lazy = true,
    keys = { "s" },
    config = function()
      require("rc/pluginconfig/vim-operator-replace")
    end,
  },

  -- The set of operator and textobject plugins to search/select/edit sandwiched textobjects.
  -- https://github.com/machakann/vim-sandwich
  {
    "machakann/vim-sandwich",
    lazy = true,
    keys = { "sa" },
    config = function()
      require("rc/pluginconfig/vim-sandwich")
    end,
  },

  -- https://github.com/kana/vim-niceblock
  { "kana/vim-niceblock",            lazy = true, keys = { "v" } },

  -----------------------------------------------------------------------------------------
  -- Editing
  -----------------------------------------------------------------------------------------

  --  🧠 💪 // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
  -- https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    keys = { { "gc", "gcc", mode = { "n", "v" } } },
    config = function()
      require("Comment").setup()
    end,
  },

  -- Highlights trailing whitespace in red and provides :FixWhitespace to fix it.
  -- https://github.com/bronson/vim-trailing-whitespace
  {
    "bronson/vim-trailing-whitespace",
    cmd = { "FixWhitespace" },
    keys = { "<Leader>tr" },
    config = function()
      require("rc/pluginconfig/vim-trailing-whitespace")
    end,
  },

  -- A Vim alignment plugin
  -- https://github.com/junegunn/vim-easy-align
  {
    "junegunn/vim-easy-align",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("rc/pluginconfig/vim-easy-align")
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

  -- repeat.vim: enable repeating supported plugin maps with "."
  -- https://github.com/tpope/vim-repeat
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  -- Use treesitter to auto close and auto rename html tag
  -- https://github.com/windwp/nvim-ts-autotag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("rc/pluginconfig/nvim-ts-autotag")
    end,
  },

  -- enhanced increment/decrement plugin for Neovim.
  -- https://github.com/monaqa/dial.nvim
  {
    "monaqa/dial.nvim",
    opt = true,
    keys = { "<C-a>", "<C-x>", "+", "-" },
    config = function()
      require("rc/pluginconfig/dial")
    end,
  },

  -- tabout plugin for neovim
  -- https://github.com/abecodes/tabout.nvim
  {
    "abecodes/tabout.nvim",
    opt = true,
    event = "InsertEnter",
    after = "nvim-cmp",
    wants = { "nvim-treesitter" },
    config = function()
      require("rc/pluginconfig/tabout")
    end,
  },

  -- Escape from insert mode without delay when typing
  -- https://github.com/max397574/better-escape.nvim
  {
    "max397574/better-escape.nvim",
    opt = true,
    event = "BufReadPost",
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
    opt = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/clever-f")
    end,
  },

  -- A vim script to provide CamelCase motion through words
  -- https://github.com/bkad/CamelCaseMotion
  -- {
  --   "bkad/CamelCaseMotion",
  --   config = function()
  --     require("rc/pluginconfig/CamelCaseMotion")
  --   end,
  -- },

  -- Incremental fuzzy search motion plugin for Neovim
  -- https://github.com/rlane/pounce.nvim
  {
    "rlane/pounce.nvim",
    opt = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/pounce")
    end,
  },

  --------------------------------------------------------------------------------
  -- File Management
  --------------------------------------------------------------------------------

  -- Open alternative files for the current buffer
  -- https://github.com/rgroli/other.nvim
  {
    "rgroli/other.nvim",
    opt = true,
    cmd = { "Other" },
    config = function()
      require("rc/pluginconfig/other")
    end,
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

  -- Rearrange your windows with ease.
  -- https://github.com/sindrets/winshift.nvim
  {
    "sindrets/winshift.nvim",
    config = function()
      require("rc/pluginconfig/winshift")
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

  -----------------------------------------------------------------------------------------
  -- Utility
  -----------------------------------------------------------------------------------------

  -- Open URI with your favorite browser from your most favorite editor
  -- https://github.com/tyru/open-browser.vim
  {
    "tyru/open-browser.vim",
    config = function()
      require("rc/pluginconfig/open-browser")
    end,
  },

  -- Open GitHub URL of current file, etc. from Vim editor (supported GitHub Enterprise)
  -- https://github.com/tyru/open-browser-github.vim
  {
    "tyru/open-browser-github.vim",
    opt = true,
    cmd = { "OpenGithubFile", "OpenGithubIssue", "OpenGithubPullReq", "OpenGithubProject" },
  },

  -- Seamless navigation between tmux panes and vim splits
  -- https://github.com/christoomey/vim-tmux-navigator
  { "christoomey/vim-tmux-navigator" },

  -- Changes Vim working directory to project root
  -- https://github.com/airblade/vim-rooter
  {
    "airblade/vim-rooter",
    cmd = { "Rooter", "RooterToggle" },
    config = function()
      require("rc/pluginconfig/vim-rooter")
    end,
  },

  -- A vim plugin to perform diffs on blocks of code
  -- https://github.com/AndrewRadev/linediff.vim
  { "AndrewRadev/linediff.vim", opt = true, cmd = { "Linediff" } },

  -- Efficient Todo.txt management in vim
  -- https://gitlab.com/dbeniamine/todo.txt-vim
  {
    "gonzoooooo/todo.txt-vim",
    ft = { "todo" },
    branch = "weekday-recurrence-support",
    config = function()
      require("rc/pluginconfig/todo_txt-vim")
    end,
  },

  -- Control Xcode from Vim
  -- https://github.com/gonzoooooo/vim-xcode-control
  {
    "gonzoooooo/vim-xcode-control",
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
  },

  -- Delete Neovim buffers without losing window layout
  -- https://github.com/famiu/bufdelete.nvim
  {
    "famiu/bufdelete.nvim",
    keys = { "<Leader>bd", "<Leader>bdd" },
    config = function()
      require("rc/pluginconfig/bufdelete")
    end,
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

  -- w3m plugin for vim
  -- https://github.com/yuratomo/w3m.vim
  {
    "yuratomo/w3m.vim",
    cmd = { "W3m", "W3mSplit", "W3mVSplit" },
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
})
