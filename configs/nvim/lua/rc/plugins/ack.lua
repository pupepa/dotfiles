return {
  -- Vim plugin for the Perl module / CLI script 'ack'
  -- https://github.com/mileszs/ack.vim
  {
    "mileszs/ack.vim",
    cmd = "Ack",
    init = function()
      if vim.fn.executable("rg") == 1 then
        vim.g.ackprg = "rg --vimgrep"
      end
    end,
  },
}
