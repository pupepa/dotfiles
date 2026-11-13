return {
  -- Performant, batteries-included completion plugin for Neovim
  -- https://github.com/saghen/blink.cmp
  {
    "saghen/blink.cmp",
    version = "1.*",
    -- blink.cmpは読み込まれたときにLSPのcapabilitiesを設定する。
    -- LSPはFileTypeで起動するため、それより前のBufReadPre/BufNewFileで読み込んでおく。
    -- コマンドラインの補完にも使うため、CmdlineEnterでも読み込む
    event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- nvim-cmp用のソースをblink.cmpで使うための互換レイヤー
      -- https://github.com/saghen/blink.compat
      { "saghen/blink.compat", version = "2.*", lazy = true, opts = {} },

      -- 以下はblink.compat経由で使うnvim-cmp用のソース
      -- https://github.com/hrsh7th/cmp-calc
      "hrsh7th/cmp-calc",
      -- https://github.com/dcampos/cmp-snippy
      { "dcampos/cmp-snippy", dependencies = { "dcampos/nvim-snippy" } },
      -- https://github.com/dmitmel/cmp-cmdline-history
      "dmitmel/cmp-cmdline-history",

      -- https://github.com/fang2hou/blink-copilot
      "fang2hou/blink-copilot",
      -- https://github.com/moyiz/blink-emoji.nvim
      "moyiz/blink-emoji.nvim",
    },
    opts = function()
      -- カーソルの直前が空白以外かどうか (<Tab>で補完を開くかの判定に使う)
      local function has_words_before()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line, col = cursor[1], cursor[2]

        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      ---@type blink.cmp.Config
      return {
        keymap = {
          preset = "none",
          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<Tab>"] = {
            "select_next",
            function(cmp)
              if has_words_before() then
                return cmp.show()
              end
            end,
            "fallback",
          },
          ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
          ["<C-Space>"] = { "show" },
          ["<C-q>"] = { "cancel", "fallback" },
          -- 候補を選択しているときだけ確定する (未選択なら通常の改行。nvim-insxの<CR>も有効)
          ["<CR>"] = { "accept", "fallback" },
        },

        completion = {
          list = {
            -- 最初の候補を自動で選択せず、選択しても確定するまで挿入しない
            selection = { preselect = false, auto_insert = false },
          },
          menu = {
            border = "rounded",
            draw = {
              -- nvim-cmpの表示 (候補 | アイコンと種類 | [ソース名]) に合わせる
              columns = {
                { "label", "label_description", gap = 1 },
                { "kind_icon", "kind", gap = 1 },
                { "source_name" },
              },
              components = {
                label = { width = { fill = true, max = 50 } },
                source_name = {
                  text = function(ctx)
                    return "[" .. ctx.source_name .. "]"
                  end,
                },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            window = { border = "rounded" },
          },
        },

        signature = {
          enabled = true,
          window = { border = "rounded" },
        },

        -- スニペットの展開とジャンプはnvim-snippyで行う
        -- (snippets_privateのバッククォートによるVim scriptの評価に対応するため)
        snippets = {
          expand = function(snippet)
            require("snippy").expand_snippet(snippet)
          end,
          active = function(filter)
            local snippy = require("snippy")
            if filter and filter.direction then
              return snippy.can_jump(filter.direction)
            end
            return snippy.is_active()
          end,
          jump = function(direction)
            local snippy = require("snippy")
            if direction < 0 then
              snippy.previous()
            else
              snippy.next()
            end
          end,
        },

        sources = {
          -- bufferはLSPの候補がないときだけ表示される (providers.lsp.fallbacksのデフォルト)
          default = { "lsp", "copilot", "snippy", "path", "emoji", "buffer", "calc" },
          per_filetype = {
            lua = { inherit_defaults = true, "lazydev" },
          },
          providers = {
            lsp = { name = "LSP" },
            path = { name = "Path" },
            buffer = { name = "Buffer" },
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
            copilot = {
              name = "Copilot",
              module = "blink-copilot",
              async = true,
            },
            emoji = {
              name = "Emoji",
              module = "blink-emoji",
            },
            snippy = {
              name = "Snippet",
              module = "blink.compat.source",
              opts = { cmp_name = "snippy" },
            },
            calc = {
              name = "Calc",
              module = "blink.compat.source",
              opts = { cmp_name = "calc" },
            },
            cmdline_history = {
              name = "History",
              module = "blink.compat.source",
              opts = { cmp_name = "cmdline_history" },
            },
          },
        },

        fuzzy = {
          sorts = { "exact", "score", "sort_text" },
        },

        cmdline = {
          keymap = {
            preset = "cmdline",
            -- 候補の表示中にカーソル移動できなくなるので、プリセットの<Left>/<Right>での選択は使わない
            ["<Left>"] = false,
            ["<Right>"] = false,
            ["<C-q>"] = { "cancel", "fallback" },
          },
          sources = function()
            local type = vim.fn.getcmdtype()
            if type == "/" or type == "?" then
              return { "buffer" }
            end
            if type == ":" or type == "@" then
              return { "cmdline", "cmdline_history" }
            end
            return {}
          end,
          completion = {
            -- 旧nvim-cmpと同じく、入力に合わせて候補を自動で表示する
            menu = { auto_show = true },
          },
        },
      }
    end,
  },
}
