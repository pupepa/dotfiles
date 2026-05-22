return {
  -- Neovim file explorer: edit your filesystem like a buffer
  -- https://github.com/stevearc/oil.nvim
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      columns = {
        "icon",
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
        winblend = 0,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 120,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
          winhighlight = "Normal:Normal,NormalFloat:Normal,FloatBorder:FloatBorder",
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "right",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
      keymaps = {
        ["<BS>"] = { "actions.parent", mode = "n" },
        ["<C-p>"] = { "actions.preview", mode = "n" },
        ["H"] = { "actions.parent", mode = "n" },
        ["g~"] = {
          desc = "Change home dir",
          callback = function()
            require("oil").open(vim.env.HOME)
          end,
        },
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = true,
    keys = {
      { "<C-n>", ":lua require('oil').toggle_float()<CR>", { noremap = true, expr = false, silent = true } },
    },
  },

  -- Async Git status integration for oil.nvim
  -- https://github.com/malewicz1337/oil-git.nvim
  {
    "malewicz1337/oil-git.nvim",
    dependencies = { "stevearc/oil.nvim" },
    event = "VeryLazy",
    opts = {
      symbols = {
        file = {
          added = "󰐗",
          modified = "󰰐",
          renamed = "󰰟",
          deleted = "󰯵",
          copied = "󰯲",
          conflict = "󰀨",
          untracked = "󰋗",
          ignored = "",
        },
        directory = {
          added = "󰐗",
          modified = "󰰐",
          renamed = "󰰟",
          deleted = "󰯵",
          copied = "󰯲",
          conflict = "󰀨",
          untracked = "󰋗",
          ignored = "",
        },
      },
    },
  },
}
