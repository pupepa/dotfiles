require("rest-nvim").setup()

vim.keymap.set("n", "<Leader>rr", "<Plug>RestNvim<CR>", { silent = true, desc = "Rest" })
vim.keymap.set("n", "<Leader>rp", "<Plug>RestNvimPreview<CR>", { silent = true, desc = "Rest preview" })
vim.keymap.set("n", "<Leader>rl", "<Plug>RestNvimLast<CR>", { silent = true, desc = "Rest last" })
