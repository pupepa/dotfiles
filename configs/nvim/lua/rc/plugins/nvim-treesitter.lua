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
    },
    -- 新環境で入れ直すときのリスト:
    --   :TSInstall bash css diff dockerfile git_rebase gitattributes gitcommit
    --   gitignore html javascript json lua python regex ruby sql swift toml tsx
    --   typescript vim vimdoc xml yaml
  },
}
