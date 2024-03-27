require("lspsaga").setup({})

vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set("n", "gn", "<Cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("x", "gn", ":<C-u>Lspsaga range_code_action<CR>", { silent = true })
vim.keymap.set("n", "gh", "<Cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "go", "<Cmd>Lspsaga goto_definition<CR>", { silent = true })
vim.keymap.set("n", "]g", "<Cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
vim.keymap.set("n", "[g", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
