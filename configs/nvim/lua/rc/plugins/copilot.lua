return {
  -- Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
  -- https://github.com/zbirenbaum/copilot.lua
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    -- 補完候補への表示はblink.cmpのソース (blink-copilot) で行う
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        todo = true,
        markdown = true,
        yaml = true,
        gitcommit = true,
      },
    },
  },
}
