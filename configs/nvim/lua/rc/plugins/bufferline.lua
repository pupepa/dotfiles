return {
  -- A snazzy bufferline for Neovim
  -- https://github.com/akinsho/bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    branch = "main",
    event = "BufReadPost",
    lazy = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "buffers",
        indicator_style = "▎",
        diagnostics = "nvim_lsp",
        modified_icon = "●",
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        get_element_icon = function(buf)
          local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(buf.filetype, { default = false })
          return icon, hl
        end,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = false,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        numbers = function(opts)
          return string.format("%s)", opts.id)
        end,
      },
    },
  },
}
