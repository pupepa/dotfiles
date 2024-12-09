---@class gtd.kit.App.Config.Schema
---@field public sources { name: string, option?: table }[] # Specify the source that will be used to search for the definition
---@field public get_buffer_path fun(): string # Specify the function to get the current buffer path. It's useful for searching path from terminal buffer etc.
---@field public on_event fun(event: gtd.Event)
---@field public on_context fun(context: gtd.Context) # Modify context on user-land.
---@field public on_cancel fun(params: gtd.Params)
---@field public on_nothing fun(params: gtd.Params)
---@field public on_location fun(params: gtd.Params, location: gtd.kit.LSP.LocationLink)
---@field public on_locations fun(params: gtd.Params, locations: gtd.kit.LSP.LocationLink[])

-- The `findup` and `lsp` source are enabled by default (at the moment).
require("gtd").setup({
  sources = {
    { name = "lsp" },
    { name = "findfile" },
    {
      name = "walk",
      option = {
        ignore_patterns = {
          "/node_modules",
          "/.git",
          "/vendor",
        },
      },
    },
  },
})

vim.keymap.set("n", "gf<CR>", function()
  require("gtd").exec({ command = "edit" })
end)

vim.keymap.set("n", "gfs", function()
  require("gtd").exec({ command = "split" })
end)

vim.keymap.set("n", "gfv", function()
  require("gtd").exec({ command = "vsplit" })
end)
