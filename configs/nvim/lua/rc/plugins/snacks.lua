return {
  -- 🍿 A collection of QoL plugins for Neovim
  -- https://github.com/folke/snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      -- 旧vim-illuminateのデフォルトキーマップに合わせる (末尾まで行ったら先頭に戻る)
      {
        "<a-n>",
        function()
          Snacks.words.jump(vim.v.count1, true)
        end,
        desc = "Next reference",
      },
      {
        "<a-p>",
        function()
          Snacks.words.jump(-vim.v.count1, true)
        end,
        desc = "Prev reference",
      },
    },
    ---@class snacks.image.Config
    opts = {
      -- カーソル下のシンボルの参照箇所をLSPのdocumentHighlightでハイライトする
      words = {
        enabled = true,
        debounce = 100,
      },
      -- vim.notifyの表示先。noiceの通知もsnacksが有効ならこちらで表示される
      notifier = {
        enabled = true,
        -- 以下は旧nvim-notifyの設定に合わせる
        timeout = 5000,
        width = { min = 50, max = 0.4 },
        top_down = false,
      },
      indent = {
        enabled = true,
        scope = { enabled = false }
      },
      image = {
        enabled = true,
        formats = {
          "png",
          "jpg",
          "jpeg",
          "gif",
          "webp",
          "heic",
        },
      },
    },
  },
}
