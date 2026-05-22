return {
  -- Plugin to improve viewing Markdown files in Neovim
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        icons = {},
        position = "inline",
        width = "block",
      },
      code = {
        conceal_delimiters = false,
      },
      pipe_table = { style = "normal" },
      win_options = {
        conceallevel = {
          rendered = 0,
        },
      },
      latex = { enabled = false },
    },
  },
}
