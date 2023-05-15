require("trim").setup({
  trim_last_line = false,
  trim_first_line = false,
})

vim.keymap.set("n", "<leader>tr", ":Trim<CR>")
