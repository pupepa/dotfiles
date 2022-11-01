vim.cmd([[
autocmd VimEnter * 1 SpeedDatingFormat %-m/%-d
autocmd VimEnter * 2 SpeedDatingFormat %Y/%m/%d
]])

-- インクリメント設定
vim.keymap.set({ "n", "x" }, "+", ":call speeddating#increment(v:count1)<CR>", { silent = true })
vim.keymap.set({ "n", "x" }, "-", ":call speeddating#increment(-v:count1)<CR>", { silent = true })
