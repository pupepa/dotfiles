return {
  -- Neovim Lua plugin to manage trailspace (highlight and remove). Part of 'mini.nvim' library.
  -- https://github.com/nvim-mini/mini.trailspace
  {
    "nvim-mini/mini.trailspace",
    version = "*",
    -- 行末の空白をファイルを開いた時点からハイライトするため、BufReadPost/BufNewFileで読み込む
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<Leader>tr",
        function()
          require("mini.trailspace").trim()
        end,
        desc = "Trim trailing whitespace",
      },
    },
    opts = {},
  },
}
