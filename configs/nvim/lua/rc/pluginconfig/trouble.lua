require("trouble").setup({})

vim.keymap.set("n", "<Leader>xx", "<cmd>TroubleToggle<CR>", { silent = true })
vim.keymap.set("n", "<Leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { silent = true })
vim.keymap.set("n", "<Leader>xd", "<cmd>Trouble document_diagnostics<CR>", { silent = true })
vim.keymap.set("n", "<Leader>xl", "<cmd>Trouble loclist<CR>", { silent = true })
vim.keymap.set("n", "<Leader>xq", "<cmd>Trouble quickfix<CR>", { silent = true })
vim.keymap.set("n", "gR", "<Cmd>Trouble lsp_references<CR>", { silent = true })
