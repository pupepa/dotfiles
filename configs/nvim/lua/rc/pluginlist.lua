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
  spec = {
    ------------------------------------------------------------------------------
    -- Lua Library
    ------------------------------------------------------------------------------
    { import = "rc.plugins.plenary" },
    { import = "rc.plugins.nui" },
    { import = "rc.plugins.nvim-bqf" },

    --------------------------------------------------------------------------------
    -- LSP & Completion
    --------------------------------------------------------------------------------
    { import = "rc.plugins.nvim-lint" },
    { import = "rc.plugins.conform" },
    -- nvim-cmpはblink.cmpに移行したため無効化している (設定ファイルは残している)
    { import = "rc.plugins.nvim-cmp", enabled = false },
    { import = "rc.plugins.blink-cmp" },
    { import = "rc.plugins.nvim-snippy" },
    { import = "rc.plugins.lazydev" },
    { import = "rc.plugins.trouble" },
    -- nvim-cmp専用のため無効化している (Tailwind CSSの色見本はblink.cmpの標準機能で表示される)
    { import = "rc.plugins.tailwindcss-colorizer-cmp", enabled = false },

    -----------------------------------------------------------------------------------------
    -- Treesitter
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.nvim-treesitter" },

    -----------------------------------------------------------------------------------------
    -- Fuzzy Finder
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.telescope" },

    -----------------------------------------------------------------------------------------
    -- UI
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.lualine" },
    { import = "rc.plugins.bufferline" },
    { import = "rc.plugins.vim-highlighturl" },
    { import = "rc.plugins.nvim-hlslens" },
    { import = "rc.plugins.gitsigns" },
    { import = "rc.plugins.aerial" },
    { import = "rc.plugins.modes" },
    { import = "rc.plugins.rainbow-delimiters" },
    { import = "rc.plugins.nvim_context_vt" },
    { import = "rc.plugins.noice" },
    { import = "rc.plugins.nvim-scrollbar" },
    { import = "rc.plugins.cellwidths" },
    { import = "rc.plugins.houston" },
    { import = "rc.plugins.codediff" },

    -----------------------------------------------------------------------------------------
    -- textobj
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.substitute" },
    { import = "rc.plugins.mini-surround" },
    { import = "rc.plugins.mini-ai" },

    -----------------------------------------------------------------------------------------
    -- Editing
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.mini-trailspace" },
    { import = "rc.plugins.make-table" },
    { import = "rc.plugins.nvim-ts-autotag" },
    { import = "rc.plugins.dial" },
    { import = "rc.plugins.better-escape" },
    { import = "rc.plugins.render-markdown" },

    -----------------------------------------------------------------------------------------
    -- Moving Cursor
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.fuzzy-motion" },
    { import = "rc.plugins.kensaku" },
    { import = "rc.plugins.copilot" },
    { import = "rc.plugins.nvim-insx" },

    --------------------------------------------------------------------------------
    -- File Management
    --------------------------------------------------------------------------------
    { import = "rc.plugins.oil" },

    --------------------------------------------------------------------------------
    -- Window
    --------------------------------------------------------------------------------
    { import = "rc.plugins.colorful-winsep" },
    { import = "rc.plugins.smart-splits" },

    -----------------------------------------------------------------------------------------
    -- Utility
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.open-browser" },
    { import = "rc.plugins.linediff" },
    { import = "rc.plugins.todo-txt" },
    { import = "rc.plugins.vim-xcode-control" },
    { import = "rc.plugins.memolist" },
    { import = "rc.plugins.rainbow_csv" },
    { import = "rc.plugins.ack" },
    { import = "rc.plugins.previm" },
    { import = "rc.plugins.vim-qfreplace" },
    { import = "rc.plugins.capture" },
    { import = "rc.plugins.vim-startuptime" },
    { import = "rc.plugins.toggleterm" },
    { import = "rc.plugins.vim-review" },
    { import = "rc.plugins.package-info" },
    { import = "rc.plugins.which-key" },
    { import = "rc.plugins.git-conflict" },
    { import = "rc.plugins.rooter" },
    { import = "rc.plugins.yank-path" },
    { import = "rc.plugins.snacks" },
    { import = "rc.plugins.git" },
    { import = "rc.plugins.wezterm-types" },
    { import = "rc.plugins.daily-notes" },
    { import = "rc.plugins.gitlinker" },
  },
}, {
  rocks = {
    enabled = false,
  },
})
