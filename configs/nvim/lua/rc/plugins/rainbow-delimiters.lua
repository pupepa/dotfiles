return {
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
}
