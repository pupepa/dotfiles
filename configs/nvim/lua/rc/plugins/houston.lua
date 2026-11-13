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
        for _, group in ipairs(groups) do
          highlights[group].bg = highlights.Normal.bg
        end

        -- houston.nvimはsnacks.nvimの通知 (SnacksNotifier*) を背景色付きで定義しているので、他のポップアップと同じく透過させる
        for name, hl in pairs(highlights) do
          if name:find("^SnacksNotifier") then
            hl.bg = highlights.Normal.bg
          end
        end

        -- snacks.nvimのwordsが使う参照箇所のハイライトを、旧vim-illuminateと同じVisualに揃える
        for _, group in ipairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
          highlights[group] = { link = "Visual" }
        end
      end,
    })
    vim.cmd.colorscheme("houston")
  end,
}
