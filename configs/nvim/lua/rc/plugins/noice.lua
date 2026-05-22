return {
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  -- https://github.com/folke/noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "hrsh7th/nvim-cmp",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
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
        backend = "cmp",
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
