-- 一時ファイルを作成して開く
vim.api.nvim_create_user_command(
  "Tempfile",
  ':edit `=expand("~/.vimtmp/" . strftime("%Y-%m-%d_%H%M%S"))` | setf markdown',
  { force = true }
)

vim.api.nvim_create_user_command("PrettyXML", ":%s/></>\r</g | setf xml | normal gg=G", { force = true })

-- Open Tig
-- vim.api.nvim_create_user_command(
--   'Tig',
--   'call system("tmux splitw -hf \'tig\'")',
--   { force = true }
-- )

-- Open Trf
vim.api.nvim_create_user_command("Trf", "call system(\"tmux splitw -vf 'trf'\")", { force = true })

-- Open Mutt
if vim.fn.executable("mutt") then
  vim.api.nvim_create_user_command("Mutt", "call system(\"tmux splitw -vf 'mutt'\")", { force = true })
end

vim.api.nvim_create_user_command("NumberToggle", function()
  vim.opt.relativenumber = not vim.opt.relativenumber._value
end, { force = true })

-- ファイルタイプのプラグインファイルを開く
vim.api.nvim_create_user_command("OpenFiletypePlugin", function()
  local home = vim.fn.expand("~/.config/nvim")
  local path = home .. "/after/ftplugin/" .. vim.bo.filetype .. ".vim"

  if vim.fn.filereadable(path) then
    vim.cmd("edit " .. path)
  else
    print(path .. " is not found.")
  end
end, { force = true })
