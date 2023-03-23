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
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { "asciidoc", "vim" },
  },
})
