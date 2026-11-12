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
