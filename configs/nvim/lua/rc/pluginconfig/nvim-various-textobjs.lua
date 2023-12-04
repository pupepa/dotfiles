require("various-textobjs").setup({ useDefaultKeymaps = true })

vim.keymap.set({ "o", "x" }, "ae", "<Cmd>lua require('various-textobjs').entireBuffer()<CR>")
