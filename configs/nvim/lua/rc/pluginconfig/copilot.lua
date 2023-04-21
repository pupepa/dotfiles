require("copilot").setup({
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = false,
      accept_word = false,
      accept_line = false,
      next = "<C-n>",
      prev = false,
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    todo = true,
    markdown = true,
    yaml = true,
  },
})

vim.keymap.set("i", "<C-S-e>", function()
  require("cmp").mapping.abort()
  require("copilot.suggestion").accept()
end, {
  desc = "[copilot] accept suggestion",
  silent = true,
})
