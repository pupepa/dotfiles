if vim.fn.has("nvim") == 1 and vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

vim.keymap.set("t", "jk", "<C-\\><C-n><Plug>(j)")
vim.keymap.set("n", "<Plug>(j)j", "ijk")
