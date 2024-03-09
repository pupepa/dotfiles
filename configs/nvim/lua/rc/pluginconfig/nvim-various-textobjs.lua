require("various-textobjs").setup({ useDefaultKeymaps = false })

vim.keymap.set({ "o", "x" }, "ae", "<Cmd>lua require('various-textobjs').entireBuffer()<CR>")
vim.keymap.set({ "o", "x" }, "ib", "<Cmd>lua require('various-textobjs').anyQuote('inner')<CR>")
vim.keymap.set({ "o", "x" }, "ab", "<Cmd>lua require('various-textobjs').anyQuote('outer')<CR>")
