require("bufferline").setup({
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
    show_tab_indicators = false,
    persist_buffer_sort = false,
    separator_style = "thin",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    numbers = function(opts)
      return string.format("%s)", opts.id)
    end,
  },
  -- highlights = {
  --   buffer_selected = {
  --     gui = "bold"
  --   },
  --   diagnostic_selected = {
  --     gui = "bold"
  --   },
  --   info_selected = {
  --     gui = "bold"
  --   },
  --   info_diagnostic_selected = {
  --     gui = "bold"
  --   },
  -- },
})
