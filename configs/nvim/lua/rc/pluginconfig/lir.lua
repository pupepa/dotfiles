local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")

require("lir").setup({
  show_hidden_files = true,
  ignore = { ".DS_Store" },
  devicons = {
    enable = true,
    highlight_dirname = true,
  },
  mappings = {
    ["<CR>"] = actions.edit,
    ["l"] = actions.edit,
    ["<C-s>"] = actions.split,
    ["v"] = actions.vsplit,

    ["h"] = actions.up,
    ["q"] = actions.quit,

    ["K"] = actions.mkdir,
    ["N"] = actions.newfile,
    ["R"] = actions.rename,
    ["@"] = actions.cd,
    ["Y"] = actions.yank_path,
    ["."] = actions.toggle_show_hidden,
    ["D"] = actions.delete,

    ["J"] = function()
      mark_actions.toggle_mark()
      vim.cmd("normal! j")
    end,
    ["C"] = clipboard_actions.copy,
    ["X"] = clipboard_actions.cut,
    ["P"] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,
    curdir_window = {
      enable = false,
      highlight_dirname = true,
    },

    win_opts = function()
      local width = math.floor(vim.o.columns * 0.7)
      local height = math.floor(vim.o.lines * 0.7)
      return {
        border = "rounded",
        width = width,
        height = height,
      }
    end,
  },
  hide_cursor = true,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lir" },
  callback = function()
    -- use visual mode
    vim.api.nvim_buf_set_keymap(
      0,
      "x",
      "J",
      ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
      { noremap = true, silent = true }
    )
  end,
})

-- custom folder icon
require("nvim-web-devicons").set_icon({
  lir_folder_icon = {
    icon = "",
    color = "#7ebae4",
    name = "LirFolderNode",
  },
})

require("lir.git_status").setup({
  show_ignored = false,
})

-- custom folder icon
vim.api.nvim_set_hl(0, "LirDir", { link = "Directory" })

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- keymaps
vim.api.nvim_set_keymap("n", "<C-n>", ':<C-u>lua require"lir.float".toggle()<CR>', { noremap = true })
