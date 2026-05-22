return {
  -- Region selection with hints on the AST nodes of a document powered by treesitter
  -- https://github.com/mfussenegger/nvim-treehopper
  {
    "mfussenegger/nvim-treehopper",
    keys = {
      {
        "m",
        function()
          require("tsht").nodes()
        end,
        mode = "o",
        desc = "Treehopper nodes",
        noremap = false,
        silent = true,
      },
      {
        "m",
        ":lua require('tsht').nodes()<CR>",
        mode = "x",
        desc = "Treehopper nodes",
        noremap = true,
        silent = true,
      },
    },
  },
}
