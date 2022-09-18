if vim.fn.executable('rg') then
  vim.g.ackprg = 'rg --vimgrep'
end
