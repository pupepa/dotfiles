return {
  "devbydaniel/houston.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("houston").setup({
      transparent = true,
      italic_comments = true,
      on_highlights = function(highlights, _colors)
        -- houston.nvimのtransparentはNormalFloatまでしか背景を消さない。
        -- そのため、ポップアップの罫線だけ背景色が残ってしまうのでNormalの背景に揃える
        local groups = { "FloatBorder", "FloatTitle", "NoiceCmdlinePopupBorder" }
        for _, level in ipairs({ "ERROR", "WARN", "INFO", "DEBUG", "TRACE" }) do
          -- nvim-notifyは本体を `NormalNC:NONE` で描画するのでBodyも合わせる
          vim.list_extend(groups, { "Notify" .. level .. "Border", "Notify" .. level .. "Body" })
        end
        for _, group in ipairs(groups) do
          highlights[group].bg = highlights.Normal.bg
        end
      end,
    })
    vim.cmd.colorscheme("houston")
  end,
}
