local group_name = "vimrc_vimrc"

vim.api.nvim_create_augroup(group_name, { clear = true })

-- ヤンクした時にハイライトする
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = group_name,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Substitute", timeout = 300 })
  end,
  once = false,
})

local restore_cursor_group = "restore_cursor"

vim.api.nvim_create_augroup(restore_cursor_group, { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = restore_cursor_group,
  callback = function()
    if vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) <= vim.fn.line("$") then
      vim.cmd('normal! g`" | zv')
    end
  end,
})

vim.cmd([[
  command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
]])
