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
    { import = "rc.plugins.popup" },

    ------------------------------------------------------------------------------
    -- Lua Library
    ------------------------------------------------------------------------------
    { import = "rc.plugins.plenary" },
    { import = "rc.plugins.sqlite" },
    { import = "rc.plugins.nui" },
    { import = "rc.plugins.nvim-bqf" },

    --------------------------------------------------------------------------------
    -- LSP & Completion
    --------------------------------------------------------------------------------
    { import = "rc.plugins.nvim-lint" },
    { import = "rc.plugins.conform" },
    { import = "rc.plugins.nvim-cmp" },
    { import = "rc.plugins.lspkind-nvim" },
    { import = "rc.plugins.nvim-snippy" },
    { import = "rc.plugins.lazydev" },
    { import = "rc.plugins.luvit-meta" },
    { import = "rc.plugins.trouble" },
    { import = "rc.plugins.fidget" },
    { import = "rc.plugins.tailwindcss-colorizer-cmp" },
    { import = "rc.plugins.typescript-tools" },

    -----------------------------------------------------------------------------------------
    -- Treesitter
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.nvim-treesitter" },
    { import = "rc.plugins.hlargs" },

    -----------------------------------------------------------------------------------------
    -- Fuzzy Finder
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.telescope" },

    -----------------------------------------------------------------------------------------
    -- UI
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.tokyonight" },
    { import = "rc.plugins.lualine" },
    { import = "rc.plugins.bufferline" },
    { import = "rc.plugins.vim-highlighturl" },
    { import = "rc.plugins.nvim-hlslens" },
    { import = "rc.plugins.gitsigns" },
    { import = "rc.plugins.indent-blankline" },
    { import = "rc.plugins.aerial" },
    { import = "rc.plugins.vim-illuminate" },
    { import = "rc.plugins.nvim-notify" },
    { import = "rc.plugins.modes" },
    { import = "rc.plugins.rainbow-delimiters" },
    { import = "rc.plugins.nvim_context_vt" },
    { import = "rc.plugins.noice" },
    { import = "rc.plugins.diffview" },
    { import = "rc.plugins.nvim-scrollbar" },
    { import = "rc.plugins.cellwidths" },

    -----------------------------------------------------------------------------------------
    -- textobj
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.nvim-various-textobjs" },
    { import = "rc.plugins.substitute" },
    { import = "rc.plugins.nvim-treehopper" },
    { import = "rc.plugins.mini-surround" },
    { import = "rc.plugins.vim-niceblock" },

    -----------------------------------------------------------------------------------------
    -- Editing
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.mini-comment" },
    { import = "rc.plugins.trim" },
    { import = "rc.plugins.make-table" },
    { import = "rc.plugins.nvim-ts-autotag" },
    { import = "rc.plugins.dial" },
    { import = "rc.plugins.better-escape" },
    { import = "rc.plugins.render-markdown" },

    -----------------------------------------------------------------------------------------
    -- Moving Cursor
    -----------------------------------------------------------------------------------------
    { import = "rc.plugins.clever-f" },
    { import = "rc.plugins.fuzzy-motion" },
    { import = "rc.plugins.kensaku" },
    { import = "rc.plugins.copilot" },
    { import = "rc.plugins.nvim-insx" },
    { import = "rc.plugins.BackAndForward" },

    --------------------------------------------------------------------------------
    -- File Management
    --------------------------------------------------------------------------------
    { import = "rc.plugins.other" },
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
    { import = "rc.plugins.open-browser-github" },
    { import = "rc.plugins.linediff" },
    { import = "rc.plugins.todo-txt" },
    { import = "rc.plugins.vim-xcode-control" },
    { import = "rc.plugins.memolist" },
    { import = "rc.plugins.rainbow_csv" },
    { import = "rc.plugins.ack" },
    { import = "rc.plugins.previm" },
    { import = "rc.plugins.close-buffers" },
    { import = "rc.plugins.vim-qfreplace" },
    { import = "rc.plugins.vim-quickrun" },
    { import = "rc.plugins.capture" },
    { import = "rc.plugins.vim-startuptime" },
    { import = "rc.plugins.toggleterm" },
    { import = "rc.plugins.vim-review" },
    { import = "rc.plugins.package-info" },
    { import = "rc.plugins.which-key" },
    { import = "rc.plugins.git-conflict" },
    { import = "rc.plugins.rooter" },
    { import = "rc.plugins.kulala" },
    { import = "rc.plugins.yank-path" },
    { import = "rc.plugins.lazygit" },
    { import = "rc.plugins.snacks" },
    { import = "rc.plugins.octo" },
    { import = "rc.plugins.git" },
    { import = "rc.plugins.wezterm-types" },
  },
}, {
  rocks = {
    enabled = false,
  },
})
