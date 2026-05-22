return {
  -- Efficient Todo.txt management in vim
  -- https://github.com/pupepa/todo.txt-vim
  {
    "pupepa/todo.txt-vim",
    ft = "todo",
    branch = "weekday-recurrence-support",
    init = function()
      vim.g.Todo_txt_do_not_map = 1
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "todo",
        callback = function()
          vim.opt_local.omnifunc = "todo#Complete"
          vim.opt_local.completeopt:remove("preview")
        end,
      })
    end,
  },
}
