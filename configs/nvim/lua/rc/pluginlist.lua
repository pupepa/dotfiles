local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
  vim.api.nvim_command("silent !git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd([[packadd packer.nvim]])

require("rc/pluginconfig/packer")

return require("packer").startup(function(use)
  use({
    "wbthomason/packer.nvim",
    opt = true,
    config = function()
      require("rc/pluginconfig/packer")
    end,
  })

  ------------------------------------------------------------------------------
  -- Lua Library
  ------------------------------------------------------------------------------

  -- [WIP] An implementation of the Popup API from vim in Neovim. Hope to upstream when complete
  -- https://github.com/nvim-lua/popup.nvim
  use({ "nvim-lua/popup.nvim", module = "popup" })

  -- All the lua functions I don't want to write twice.
  -- https://github.com/nvim-lua/plenary.nvim
  use({ "nvim-lua/plenary.nvim" }) -- do not lazy load

  -- SQLite LuaJIT binding with a very simple api.
  -- https://github.com/kkharji/sqlite.lua
  use({ "kkharji/sqlite.lua", module = "sqlite" })

  -- UI Component Library for Neovim.
  -- https://github.com/MunifTanjim/nui.nvim
  use({ "MunifTanjim/nui.nvim", module = "nui" })

  -- Better quickfix window in Neovim, polish old quickfix window.
  -- https://github.com/kevinhwang91/nvim-bqf
  use({
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  })

  --------------------------------------------------------------------------------
  -- LSP & Completion
  --------------------------------------------------------------------------------

  -- External package Installer
  -- https://github.com/williamboman/mason.nvim
  use({
    "williamboman/mason.nvim",
    requires = {
      -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
      -- https://github.com/williamboman/mason-lspconfig.nvim
      "williamboman/mason-lspconfig.nvim",
    },
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/mason")
    end,
  })

  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  -- https://github.com/jose-elias-alvarez/null-ls.nvim
  use({
    "jose-elias-alvarez/null-ls.nvim",
    after = "mason.nvim",
    config = function()
      require("rc/pluginconfig/null-ls")
    end,
  })

  -- https://github.com/jay-babu/mason-null-ls.nvim
  use({
    "jayp0521/mason-null-ls.nvim",
    after = "null-ls.nvim",
    config = function()
      require("mason-null-ls").setup()
    end,
  })

  -- A completion plugin for neovim coded in Lua.
  -- https://github.com/hrsh7th/nvim-cmp
  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("rc/pluginconfig/nvim-cmp")
    end,
  })

  -- vscode-like pictograms for neovim lsp completion items
  -- https://github.com/onsails/lspkind.nvim
  use({
    "onsails/lspkind-nvim",
    module = "lspkind",
    config = function()
      require("rc/pluginconfig/lspkind-nvim")
    end,
  })

  -- nvim-cmp source for neovim builtin LSP client
  -- https://github.com/hrsh7th/cmp-nvim-lsp
  use({ "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" })

  -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
  -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
  use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })

  -- use({ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" })

  -- nvim-cmp source for buffer words.
  -- https://github.com/hrsh7th/cmp-buffer
  use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })

  -- nvim-cmp source for filesystem paths.
  -- https://github.com/hrsh7th/cmp-path
  use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

  -- use({ "hrsh7th/cmp-omni", after = "nvim-cmp" })

  -- nvim-cmp source for neovim Lua API.
  -- https://github.com/hrsh7th/cmp-nvim-lua
  use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })

  -- nvim-cmp source for emojis.
  -- https://github.com/hrsh7th/cmp-emoji
  use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })

  -- nvim-cmp source for math calculation.
  -- https://github.com/hrsh7th/cmp-calc
  use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })

  -- spell source for nvim-cmp based on vim's spellsuggest.
  -- https://github.com/f3fora/cmp-spell
  use({ "f3fora/cmp-spell", after = "nvim-cmp" })

  -- cmp source for treesitter
  -- https://github.com/ray-x/cmp-treesitter
  use({ "ray-x/cmp-treesitter", after = "nvim-cmp" })

  -- use({ "lukas-reineke/cmp-rg", after = "nvim-cmp" })

  use({ "dcampos/cmp-snippy", after = "nvim-cmp" })

  use({ "andersevenrud/cmp-tmux", after = "nvim-cmp" })

  -- nippet plugin for Neovim
  -- https://github.com/dcampos/nvim-snippy
  use({
    "dcampos/nvim-snippy",
    config = function()
      require("rc/pluginconfig/nvim-snippy")
    end,
  })

  -- nvim-cmp comparator function for completion items that start with one or more underlines
  -- https://github.com/lukas-reineke/cmp-under-comparator
  use({ "lukas-reineke/cmp-under-comparator", module = "cmp-under-comparator" })

  -- autopairs for neovim written by lua
  -- https://github.com/windwp/nvim-autopairs
  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("rc/pluginconfig/nvim-autopairs")
    end,
  })

  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
  -- https://github.com/williamboman/mason-lspconfig.nvim
  use({
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("rc/pluginconfig/mason-lspconfig")
    end,
  })

  -- Quickstart configs for Nvim LSP
  -- https://github.com/neovim/nvim-lspconfig
  use({
    "neovim/nvim-lspconfig",
    opt = false,
    config = function()
      require("rc/pluginconfig/nvim-lspconfig")
    end,
  })

  -- neovim lsp plugin
  -- https://github.com/glepnir/lspsaga.nvim
  use({
    "glepnir/lspsaga.nvim",
    opt = false,
    after = { "nvim-lspconfig" },
    config = function()
      require("rc/pluginconfig/lspsaga")
    end,
  })

  -- Plugin that creates missing LSP diagnostics highlight groups for color schemes that don't yet support the Neovim 0.5 builtin LSP client.
  -- https://github.com/folke/lsp-colors.nvim
  use({
    "folke/lsp-colors.nvim",
    module = "lsp-colors",
  })

  -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  -- https://github.com/folke/trouble.nvim
  use({
    "folke/trouble.nvim",
    opt = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = function()
      require("rc/pluginconfig/trouble")
    end,
  })

  -- Standalone UI for nvim-lsp progress
  -- https://github.com/j-hui/fidget.nvim
  use({
    "j-hui/fidget.nvim",
    after = "mason.nvim",
    config = function()
      require("rc/pluginconfig/fidget")
    end,
  })

  -----------------------------------------------------------------------------------------
  -- Treesitter
  -----------------------------------------------------------------------------------------

  -- Nvim Treesitter configurations and abstraction layer
  -- https://github.com/nvim-treesitter/nvim-treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    opt = true,
    event = "BufReadPost",
    run = ":TSUpdate",
    config = function()
      require("rc/pluginconfig/nvim-treesitter")
    end,
  })

  -----------------------------------------------------------------------------------------
  -- Fuzzy Finder
  -----------------------------------------------------------------------------------------

  -- mproved fzf.vim written in lua
  -- https://github.com/ibhagwan/fzf-lua
  use({
    "ibhagwan/fzf-lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("rc/pluginconfig/fzf-lua")
    end,
  })

  -----------------------------------------------------------------------------------------
  -- UI
  -----------------------------------------------------------------------------------------

  -- A highly customizable theme for vim and neovim with support for lsp, treesitter and a variety of plugins.
  -- https://github.com/EdenEast/nightfox.nvim
  use({
    "EdenEast/nightfox.nvim",
    config = function()
      require("rc/pluginconfig/nightfox")
    end,
  })

  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  -- https://github.com/nvim-lualine/lualine.nvim
  use({
    "nvim-lualine/lualine.nvim",
    opt = false,
    after = { "nvim-lspconfig", "lspsaga.nvim" },
    config = function()
      require("rc/pluginconfig/lualine")
    end,
  })

  -- A snazzy bufferline for Neovim
  -- https://github.com/akinsho/bufferline.nvim
  use({
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    event = "BufReadPost",
    opt = true,
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("rc/pluginconfig/bufferline")
    end,
  })

  --URL highlight everywhere
  -- https://github.com/itchyny/vim-highlighturl
  use({
    "itchyny/vim-highlighturl",
    config = function()
      require("rc/pluginconfig/vim-highlighturl")
    end,
  })

  -- Hlsearch Lens for Neovim
  -- https://github.com/kevinhwang91/nvim-hlslens
  use({
    "kevinhwang91/nvim-hlslens",
    requires = "haya14busa/vim-asterisk",
    config = function()
      require("rc/pluginconfig/nvim-hlslens")
    end,
  })

  -- Git integration for buffers
  -- https://github.com/lewis6991/gitsigns.nvim
  use({
    "lewis6991/gitsigns.nvim",
    event = { "FocusLost", "CursorHold" },
    config = function()
      require("rc/pluginconfig/gitsigns")
    end,
  })

  -- Indent guides for Neovim
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  use({
    "lukas-reineke/indent-blankline.nvim",
    opt = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/indent-blankline")
    end,
  })

  -- Extensible Neovim Scrollbar
  -- https://github.com/petertriho/nvim-scrollbar
  use({
    "petertriho/nvim-scrollbar",
    config = function()
      require("rc/pluginconfig/nvim-scrollbar")
    end,
  })

  -- Neovim plugin to preview the contents of the registers
  -- https://github.com/tversteeg/registers.nvim
  use({
    "tversteeg/registers.nvim",
    branch = "main",
    config = function()
      require("rc/pluginconfig/registers")
    end,
  })

  -- Neovim plugin for a code outline window
  -- https://github.com/stevearc/aerial.nvim
  use({
    "stevearc/aerial.nvim",
    config = function()
      require("rc/pluginconfig/aerial")
    end,
  })

  -- illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
  -- https://github.com/RRethy/vim-illuminate
  use({
    "RRethy/vim-illuminate",
    opt = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/vim-illuminate")
    end,
  })

  use({
    "rcarriga/nvim-notify",
    opt = false,
    config = function()
      require("rc/pluginconfig/nvim-notify")
    end,
  })

  -----------------------------------------------------------------------------------------
  -- textobj
  -----------------------------------------------------------------------------------------

  -- Vim plugin: Create your own text objects
  -- https://github.com/kana/vim-textobj-user
  use({
    "kana/vim-textobj-user",
    opt = true,
    event = "BufEnter",
    requires = {
      -- Vim plugin: Text objects for entire buffer
      -- https://github.com/kana/vim-textobj-entire
      { "kana/vim-textobj-entire", opt = true },

      -- Vim plugin: Text objects for the current line
      -- https://github.com/kana/vim-textobj-line
      { "kana/vim-textobj-line", opt = true },

      -- https://github.com/kana/vim-textobj-indent
      { "kana/vim-textobj-indent", opt = true },

      -- The vim textobject plugin to treat function-call regions.
      -- https://github.com/machakann/vim-textobj-functioncall
      { "machakann/vim-textobj-functioncall", opt = true },

      -- https://github.com/mattn/vim-textobj-url
      { "mattn/vim-textobj-url", opt = true },

      -- https://github.com/osyo-manga/vim-textobj-multiblock
      { "osyo-manga/vim-textobj-multiblock", opt = true },

      -- https://github.com/pocke/vim-textobj-markdown
      { "pocke/vim-textobj-markdown", opt = true },

      -- A fork of textobj-parameter 0.1.0
      -- https://github.com/sgur/vim-textobj-parameter
      { "sgur/vim-textobj-parameter", opt = true },

      -- A text object to turn foo_bar_baz into foo_baz *and* quuxSpamEggs into quuxEggs *and* shine your shoes
      -- https://github.com/Julian/vim-textobj-variable-segment
      { "julian/vim-textobj-variable-segment", opt = true },

      -- Vim plugin: Text objects for date and time
      -- https://github.com/kana/vim-textobj-datetime
      { "kana/vim-textobj-datetime", opt = true },
    },
  })

  -- Vim plugin: Operator to replace text with register content
  -- https://github.com/yuki-yano/vim-operator-replace
  use({
    "yuki-yano/vim-operator-replace",
    requires = "kana/vim-operator-user",
    config = function()
      require("rc/pluginconfig/vim-operator-replace")
    end,
  })

  -- The set of operator and textobject plugins to search/select/edit sandwiched textobjects.
  -- https://github.com/machakann/vim-sandwich
  use({
    "machakann/vim-sandwich",
    config = function()
      require("rc/pluginconfig/vim-sandwich")
    end,
  })

  -- https://github.com/kana/vim-niceblock
  use({ "kana/vim-niceblock" })

  -----------------------------------------------------------------------------------------
  -- Editing
  -----------------------------------------------------------------------------------------

  -- Vim comment plugin: supported operator/non-operator mappings, repeatable by dot-command, 300+ filetypes
  -- https://github.com/tyru/caw.vim
  use({ "tyru/caw.vim", opt = true, event = "BufReadPost" })

  -- Highlights trailing whitespace in red and provides :FixWhitespace to fix it.
  -- https://github.com/bronson/vim-trailing-whitespace
  use({
    "bronson/vim-trailing-whitespace",
    cmd = { "FixWhitespace" },
    config = function()
      require("rc/pluginconfig/vim-trailing-whitespace")
    end,
  })

  -- A Vim alignment plugin
  -- https://github.com/junegunn/vim-easy-align
  use({
    "junegunn/vim-easy-align",
    config = function()
      require("rc/pluginconfig/vim-easy-align")
    end,
  })

  -- https://github.com/mattn/vim-maketable
  use({
    "mattn/vim-maketable",
    cmd = { "MakeTable" },
  })

  -- Edits part of buffer by another buffer.
  -- https://github.com/thinca/vim-partedit
  use({
    "thinca/vim-partedit",
    cmd = { "PartEdit", "ParteditEnd", "MyParteditContext" },
    config = function()
      require("rc/pluginconfig/vim-partedit")
    end,
  })

  -- repeat.vim: enable repeating supported plugin maps with "."
  -- https://github.com/tpope/vim-repeat
  use({ "tpope/vim-repeat" })

  -- Use treesitter to auto close and auto rename html tag
  -- https://github.com/windwp/nvim-ts-autotag
  use({
    "windwp/nvim-ts-autotag",
    opt = true,
    after = "nvim-treesitter",
    config = function()
      require("rc/pluginconfig/nvim-ts-autotag")
    end,
  })

  -- enhanced increment/decrement plugin for Neovim.
  -- https://github.com/monaqa/dial.nvim
  use({
    "monaqa/dial.nvim",
    opt = true,
    keys = { "<C-a>", "<C-x>", "+", "-" },
    config = function()
      require("rc/pluginconfig/dial")
    end,
  })

  -- tabout plugin for neovim
  -- https://github.com/abecodes/tabout.nvim
  use({
    "abecodes/tabout.nvim",
    opt = true,
    event = "InsertEnter",
    after = "nvim-cmp",
    wants = { "nvim-treesitter" },
    config = function()
      require("rc/pluginconfig/tabout")
    end,
  })

  -- Escape from insert mode without delay when typing
  -- https://github.com/max397574/better-escape.nvim
  use({
    "max397574/better-escape.nvim",
    opt = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/better-escape")
    end,
  })

  -----------------------------------------------------------------------------------------
  -- Moving Cursor
  -----------------------------------------------------------------------------------------

  -- Extended f, F, t and T key mappings for Vim.
  -- https://github.com/rhysd/clever-f.vim
  use({
    "rhysd/clever-f.vim",
    opt = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/clever-f")
    end,
  })

  -- A vim script to provide CamelCase motion through words
  -- https://github.com/bkad/CamelCaseMotion
  -- use({
  --   "bkad/CamelCaseMotion",
  --   config = function()
  --     require("rc/pluginconfig/CamelCaseMotion")
  --   end,
  -- })

  --------------------------------------------------------------------------------
  -- File Management
  --------------------------------------------------------------------------------

  -- Open alternative files for the current buffer
  -- https://github.com/rgroli/other.nvim
  use({
    "rgroli/other.nvim",
    opt = true,
    cmd = { "Other" },
    config = function()
      require("rc/pluginconfig/other")
    end,
  })

  -- Directory viewer for Vim
  -- https://github.com/justinmk/vim-dirvish
  use({
    "justinmk/vim-dirvish",
    opt = true,
    keys = { "<C-n>" },
    config = function()
      require("rc/pluginconfig/vim-dirvish")
    end,
  })

  -- File manipulation commands for vim-dirvish
  -- https://github.com/roginfarrer/vim-dirvish-dovish
  use({
    "roginfarrer/vim-dirvish-dovish",
    after = "vim-dirvish",
    config = function()
      require("rc/pluginconfig/vim-dirvish-dovish")
    end,
  })

  -----------------------------------------------------------------------------------------
  -- Utility
  -----------------------------------------------------------------------------------------

  -- Open URI with your favorite browser from your most favorite editor
  -- https://github.com/tyru/open-browser.vim
  use({
    "tyru/open-browser.vim",
    config = function()
      require("rc/pluginconfig/open-browser")
    end,
  })

  -- Open GitHub URL of current file, etc. from Vim editor (supported GitHub Enterprise)
  -- https://github.com/tyru/open-browser-github.vim
  use({
    "tyru/open-browser-github.vim",
    opt = true,
    cmd = { "OpenGithubFile", "OpenGithubIssue", "OpenGithubPullReq", "OpenGithubProject" },
  })

  -- Seamless navigation between tmux panes and vim splits
  -- https://github.com/christoomey/vim-tmux-navigator
  use({ "christoomey/vim-tmux-navigator" })

  -- Changes Vim working directory to project root
  -- https://github.com/airblade/vim-rooter
  use({
    "airblade/vim-rooter",
    config = function()
      require("rc/pluginconfig/vim-rooter")
    end,
  })

  -- A vim plugin to perform diffs on blocks of code
  -- https://github.com/AndrewRadev/linediff.vim
  use({ "AndrewRadev/linediff.vim", opt = true, cmd = { "Linediff" } })

  -- vim match-up: even better % 👊 navigate and highlight matching words 👊 modern matchit and matchparen replacement
  -- https://github.com/andymass/vim-matchup
  use({
    "andymass/vim-matchup",
    opt = true,
    after = "nvim-treesitter",
    config = function()
      require("rc/pluginconfig/vim-matchup")
    end,
  })

  -- Efficient Todo.txt management in vim
  -- https://gitlab.com/dbeniamine/todo.txt-vim
  use({
    "gonzoooooo/todo.txt-vim",
    ft = { "todo" },
    branch = "weekday-recurrence-support",
    config = function()
      require("rc/pluginconfig/todo_txt-vim")
    end,
  })

  -- Control Xcode from Vim
  -- https://github.com/gonzoooooo/vim-xcode-control
  use({
    "gonzoooooo/vim-xcode-control",
    ft = { "swift", "objc" },
    config = function()
      require("rc/pluginconfig/vim-xcode-control")
    end,
  })

  -- simple memo plugin for Vim.
  -- https://github.com/glidenote/memolist.vim
  use({
    "glidenote/memolist.vim",
    cmd = { "MemoNew", "MemoList", "MemoGrep" },
    config = function()
      require("rc/pluginconfig/memolist")
    end,
  })

  -- Run your tests at the speed of thought
  -- https://github.com/janko/vim-test
  use({
    "janko-m/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = function()
      require("rc/pluginconfig/vim-test")
    end,
  })

  -- Vim plugin: Create your own submodes
  -- https://github.com/kana/vim-submode
  use({
    "kana/vim-submode",
    opt = true,
    event = "BufReadPost",
    config = function()
      require("rc/pluginconfig/vim-submode")
    end,
  })

  -- Rainbow CSV - Vim plugin: Highlight columns in CSV and TSV files and run queries in SQL-like language
  -- https://github.com/mechatroner/rainbow_csv
  use({
    "mechatroner/rainbow_csv",
    ft = "csv",
  })

  -- Vim plugin for the Perl module / CLI script 'ack'
  -- https://github.com/mileszs/ack.vim
  use({
    "mileszs/ack.vim",
    cmd = "Ack",
    config = function()
      require("rc/pluginconfig/ack")
    end,
  })

  -- Realtime preview by Vim. (Markdown, reStructuredText, textile)
  -- https://github.com/previm/previm
  use({
    "previm/previm",
    ft = { "markdown", "asciidoc" },
  })

  -- Git repo for http://www.vim.org/scripts/script.php?script_id=1147
  -- https://github.com/qpkorr/vim-bufkill
  use({
    "qpkorr/vim-bufkill",
    config = function()
      require("rc/pluginconfig/vim-bufkill")
    end,
  })

  -- Vim plugin for generating images of source code using https://github.com/Aloxaf/silicon
  -- https://github.com/segeljakt/vim-silicon
  use({
    "segeljakt/vim-silicon",
    cmd = { "Silicon" },
    config = function()
      require("rc/pluginconfig/vim-silicon")
    end,
  })

  -- Ctags generator for Vim
  -- https://github.com/szw/vim-tags
  use({
    "szw/vim-tags",
    cmd = { "TagsGenerate" },
    config = function()
      require("rc/pluginconfig/vim-tags")
    end,
  })

  -- Perform the replacement in quickfix.
  -- https://github.com/thinca/vim-qfreplace
  use({
    "thinca/vim-qfreplace",
    cmd = { "Qfreplace" },
  })

  -- Run commands quickly.
  -- https://github.com/thinca/vim-quickrun
  use({
    "thinca/vim-quickrun",
    cmd = { "QuickRun" },
    config = function()
      require("rc/pluginconfig/vim-quickrun")
    end,
  })

  -- Integrated reference viewer.
  -- https://github.com/thinca/vim-ref
  use({
    "thinca/vim-ref",
    cmd = { "Ref" },
    config = function()
      require("rc/pluginconfig/vim-ref")
    end,
  })

  -- Show Ex command output in buffer
  -- https://github.com/tyru/capture.vim
  use({
    "tyru/capture.vim",
    cmd = { "Capture" },
  })

  -- Swap your windows without ruining your layout
  -- https://github.com/wesQ3/vim-windowswap
  use({
    "wesQ3/vim-windowswap",
    cmd = { "WindowSwap#MarkWindowSwap", "WindowSwap#DoWindowSwap", "WindowSwap#EasyWindowSwap" },
  })

  -- w3m plugin for vim
  -- https://github.com/yuratomo/w3m.vim
  use({
    "yuratomo/w3m.vim",
    cmd = { "W3m", "W3mSplit", "W3mVSplit" },
  })

  -- A plugin for profiling Vim and Neovim startup time.
  -- https://github.com/dstein64/vim-startuptime
  use({
    "dstein64/vim-startuptime",
    cmd = { "StartupTime" },
    config = function()
      require("rc/pluginconfig/vim-startuptime")
    end,
  })

  -- A neovim lua plugin to help easily manage multiple terminal windows
  -- https://github.com/akinsho/toggleterm.nvim
  use({
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("rc/pluginconfig/toggleterm")
    end,
  })
end)
