local aerial = require("aerial")

aerial.setup({
  layout = {
    -- These control the width of the aerial window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a list of mixed types.
    -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
    max_width = { 80, 0.5 },
    width = nil,
    min_width = 20,

    -- key-value pairs of window-local options for aerial window (e.g. winhl)
    win_opts = {
      winblend = 30,
    },

    -- Determines the default direction to open the aerial window. The 'prefer'
    -- options will open the window in the other direction *if* there is a
    -- different buffer in the way of the preferred direction
    -- Enum: prefer_right, prefer_left, right, left, float
    default_direction = "float",

    -- Determines where the aerial window will be opened
    --   edge   - open aerial at the far right/left of the editor
    --   window - open aerial to the right/left of the current window
    placement = "window",
  },

  -- Options for opening aerial in a floating win
  float = {
    -- Controls border appearance. Passed to nvim_open_win
    border = "rounded",

    -- Determines location of floating window
    --   cursor - Opens float on top of the cursor
    --   editor - Opens float centered in the editor
    --   win    - Opens float centered in the window
    relative = "win",

    -- These control the height of the floating window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a list of mixed types.
    -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
    max_height = 0.9,
    height = nil,
    min_height = { 8, 0.1 },

    override = function(conf, source_winid)
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout

      -- vim.pretty_print { conf = conf, source_winid = source_winid }
      conf.anchor = "NE"
      conf.col = vim.fn.winwidth(source_winid)
      conf.row = 0
      return conf
    end,
  },
})

vim.keymap.set("n", "<Leader>ae", function()
  aerial.toggle({ focus = false })
end)

vim.keymap.set("n", "<Leader>af", function()
  aerial.open({ focus = false })
  aerial.focus()
end)
