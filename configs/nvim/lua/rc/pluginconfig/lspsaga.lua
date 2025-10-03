require("lspsaga").setup({
  lightbulb = {
    enable = false,
  },
  outline = {
    win_position = "right",
    auto_preview = true,
    detail = true,
    auto_close = true,
    close_after_jump = true,
    layout = "float",
    keys = {
      toggle_or_jump = "<cr>",
      quit = { "q", "<ESC>" },
      jump = "e",
    },
  },
})

-- vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set("n", "gn", "<Cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("x", "gn", ":<C-u>Lspsaga range_code_action<CR>", { silent = true })
vim.keymap.set("n", "gh", "<Cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "go", "<Cmd>Lspsaga goto_definition<CR>", { silent = true })
vim.keymap.set("n", "gr", "<Cmd>Lspsaga finder<CR>", { silent = true })
vim.keymap.set("n", "gl", "<Cmd>Lspsaga outline<CR>", { silent = true })
vim.keymap.set("n", "gp", "<Cmd>Lspsaga panel<CR>", { silent = true })
vim.keymap.set("n", "]g", "<Cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
vim.keymap.set("n", "[g", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
