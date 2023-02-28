local fb_actions = require("telescope").extensions.file_browser.actions
local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
        prompt_position = "top",
        preview_width = 0.4,
      },
      vertical = { mirror = false },
      width = 0.8,
      height = 0.7,
    },
    mappings = {
      i = {
        ["qq"] = actions.close,
      },
      n = {
        ["q"] = actions.close,
      },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<C-h>"] = fb_actions.goto_parent_dir,
        },
        ["n"] = {
          ["h"] = fb_actions.goto_parent_dir,
          ["l"] = require("telescope.actions").select_default,
          ["."] = fb_actions.toggle_hidden,
        },
      },
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    },
  },
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-n>", ":Telescope file_browser<CR>", { silent = true })
vim.keymap.set("n", "<Space>g", builtin.live_grep, {})
vim.keymap.set("n", "<Space>b", builtin.buffers, {})
vim.keymap.set("n", "<Space>c", builtin.command_history, {})
vim.keymap.set("n", "<Space>q", "<Cmd>:Telescope ghq list<CR>", { silent = true })
vim.keymap.set("n", "<Space>r", "<Cmd>:Telescope oldfiles<CR>", { silent = true })
vim.keymap.set("n", "<Space>f", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", { silent = true })
vim.keymap.set("n", "<Space>l", "<Cmd>lua require('telescope').extensions.lines.lines()<CR>", { silent = true })

require("telescope").load_extension("frecency")
require("telescope").load_extension("packer")
require("telescope").load_extension("lines")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")
require("telescope").load_extension("ghq")
require("telescope").load_extension("gh")
require("telescope").load_extension("ui-select")
