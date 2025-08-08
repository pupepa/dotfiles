require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    todo = true,
    markdown = true,
    yaml = true,
    gitcommit = true,
  },
})

vim.keymap.set("i", "<C-S-e>", function()
  require("cmp").mapping.abort()
  require("copilot.suggestion").accept()
end, {
  desc = "[copilot] accept suggestion",
  silent = true,
})
