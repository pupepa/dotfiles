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
})
