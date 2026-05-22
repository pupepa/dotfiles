return {
  -- Nvim Treesitter configurations and abstraction layer
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter").setup({
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
          "python",
          "regex",
          "ruby",
          "sql",
          "swift",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
        ignore_install = { "csv" },
        sync_install = false,
        auto_install = true,
      })
      vim.treesitter.language.register("typescript", "tsx")
    end,
  },

  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
  },
}
