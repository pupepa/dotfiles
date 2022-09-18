if !isdirectory(g:plug_home . '/modes.nvim') || !has('nvim')
  finish
endif

lua <<EOF

require('modes').setup({
  colors = {
    copy = "#f5c359",
    delete = "#c75c6a",
    insert = "#c2cc78",
    visual = "#008000"
  },

  -- Cursorline highlight opacity
  line_opacity = 0.1,

  -- Highlight cursor
  set_cursor = true,

  -- Highlight in active window only
  focus_only = false
})

EOF
