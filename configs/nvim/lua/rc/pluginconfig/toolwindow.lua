vim.keymap.set("n", "<Leader>bc", "<Cmd>lua require('toolwindow').close()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>bt", "<Cmd>lua require('toolwindow').open_window('quickfix', nil)<CR>", { silent = true })
vim.keymap.set("n", "<Leader>bt", "<Cmd>lua require('toolwindow').open_window('term', nil)<CR>", { silent = true })
vim.keymap.set("n", "<Leader>bd", "<Cmd>lua require('toolwindow').open_window('trouble', nil)<CR>", { silent = true })
