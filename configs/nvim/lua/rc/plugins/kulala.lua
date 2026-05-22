return {
  --A fully-featured 🤏 HTTP-client 🐼 interface 🖥️ for Neovim ❤️.
  -- https://github.com/mistweaverco/kulala.nvim
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      kulala_keymaps_prefix = "",
      global_keymaps = {
        ["Send request"] = {
          "<leader>Rs",
          function()
            require("kulala").run()
          end,
          mode = { "n", "v" },
          desc = "Send request",
        },
        ["Send all requests"] = {
          "<leader>Ra",
          function()
            require("kulala").run_all()
          end,
          mode = { "n", "v" },
          ft = { "http", "rest" },
        },
      },
    },
  },
}
