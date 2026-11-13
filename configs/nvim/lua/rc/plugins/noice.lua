return {
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  -- https://github.com/folke/noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        {
          filter = { event = "notify", find = "No information available" },
          opts = { skip = true },
        },
      },
      messages = {
        view_search = false, -- use hlslens
      },
      cmdline = {
        view = "cmdline_popup",
      },
      popupmenu = {
        enabled = true,
        -- コマンドラインの補完はblink.cmpが表示する。標準の補完 (wildmenu) を使うときはnuiで表示する
        backend = "nui",
      },
      views = {
        cmdline_popup = {
          position = {
            row = "70%",
            col = "50%",
          },
          win_options = {
            winhighlight = {
              NormalFloat = "NoiceCmdlinePopupNormal",
              FloatBorder = "NoiceCmdlinePopupBorder",
            },
          },
        },
        cmdline_popupmenu = {
          win_options = {
            winhighlight = {
              NormalFloat = "NoiceCmdlinePopupmenuNormal",
              FloatBorder = "NoiceCmdlinePopupmenuBorder",
            },
          },
        },
        hover = {
          border = { style = "rounded" },
        },
      },
    },
  },
}
