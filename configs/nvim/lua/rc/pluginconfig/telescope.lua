local status, telescope = pcall(require, "telescope")

if not status then
  return
end

local fb_actions = require("telescope").extensions.file_browser.actions
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      ".DS_Store",
      ".git/",
      "target/",
      "docs/",
      "vendor/*",
      "%.lock",
      "__pycache__/*",
      "%.sqlite3",
      "%.ipynb",
      "node_modules/*",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.webp",
      ".dart_tool/",
      ".github/",
      ".gradle/",
      ".idea/",
      ".settings/",
      ".vscode/",
      "__pycache__/",
      "build/",
      "env/",
      "gradle/",
      "node_modules/",
      "%.pdb",
      "%.dll",
      "%.class",
      "%.exe",
      "%.cache",
      "%.ico",
      "%.pdf",
      "%.dylib",
      "%.jar",
      "%.docx",
      "%.met",
      "smalljre_*/*",
      ".vale/",
      "%.burp",
      "%.mp4",
      "%.mkv",
      "%.rar",
      "%.zip",
      "%.7z",
      "%.tar",
      "%.bz2",
      "%.epub",
      "%.flac",
      "%.tar.gz",
    },
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
        ["<C-d>"] = actions.delete_buffer,
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

vim.keymap.set("n", "<C-p>", function()
  builtin.find_files({ hidden = true })
end, { silent = true })

vim.keymap.set("n", "<C-n>", function()
  telescope.extensions.file_browser.file_browser({
    hidden = true,
    hide_parent_dir = true,
  })
end, { silent = true })
-- vim.keymap.set("n", "<C-n>", ":Telescope file_browser<CR>", { silent = true })
vim.keymap.set("n", "<Space>g", builtin.live_grep, {})
vim.keymap.set("n", "<Space>b", builtin.buffers, {})
vim.keymap.set("n", "<Space>c", builtin.command_history, {})
vim.keymap.set("n", "<Space>q", "<Cmd>:Telescope ghq list<CR>", { silent = true })
vim.keymap.set("n", "<Space>r", "<Cmd>:Telescope oldfiles<CR>", { silent = true })
vim.keymap.set("n", "<Space>f", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", { silent = true })
vim.keymap.set("n", "<Space>l", "<Cmd>lua require('telescope').extensions.lines.lines()<CR>", { silent = true })

require("telescope").load_extension("frecency")
require("telescope").load_extension("lines")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")
require("telescope").load_extension("ghq")
require("telescope").load_extension("gh")
require("telescope").load_extension("ui-select")
