return {
  -- Neovim Lua plugin to extend and create `a`/`i` textobjects. Part of 'mini.nvim' library.
  -- https://github.com/nvim-mini/mini.ai
  {
    "nvim-mini/mini.ai",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      -- Miscellaneous functionality for mini.nvim (gen_ai_spec)
      -- https://github.com/nvim-mini/mini.extra
      { "nvim-mini/mini.extra", version = "*" },
    },
    opts = function()
      local gen_ai_spec = require("mini.extra").gen_ai_spec

      return {
        custom_textobjects = {
          -- 引用符 (", ', `)。標準のbは括弧なので、旧nvim-various-textobjsのib/abに合わせて上書き
          ["b"] = { { "%b''", '%b""', "%b``" }, "^.().*().$" },
          -- 「」。mini.surroundのcustom_surroundingsに合わせる (例: gsicで「」の内側を置換)
          ["c"] = { "「().-()」" },
          -- バッファ全体 (ieは前後の空行を除く)
          ["e"] = gen_ai_spec.buffer(),
          -- 現在行 (ilはインデントを除く)
          ["l"] = gen_ai_spec.line(),
          -- URL (パターンはnvim-various-textobjsのものに前方境界を追加)
          ["u"] = { "%f[%l]%l%l%l+://[^%s)%]}\"'`>]+" },
        },
        mappings = {
          -- il/alを上記lのテキストオブジェクトとして使うため、last系のマッピングを無効化
          around_last = "",
          inside_last = "",
        },
      }
    end,
  },
}
