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
        -- 見出し行の背景ブロックの色をH1〜H6まで全てH1と同じ色に揃える
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH1Bg",
          "RenderMarkdownH1Bg",
          "RenderMarkdownH1Bg",
          "RenderMarkdownH1Bg",
          "RenderMarkdownH1Bg",
        },
      },
      code = {
        conceal_delimiters = false,
        -- ターミナルの半透明背景を活かすため、コードブロックの背景塗りつぶしを無効化
        disable_background = true,
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
