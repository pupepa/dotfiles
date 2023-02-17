vim.g["sandwich#recipes"] = vim.tbl_extend("force", vim.deepcopy(vim.g["sandwich#default_recipes"]), {
  {
    buns = { "${", "}" },
    input = { "$" },
    filetype = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  {
    buns = { "#{", "}" },
    input = { "#" },
    filetype = { "ruby", "eruby" },
  },
  {
    buns = { "「", "」" },
    input = { "c" },
  },
  {
    buns = { "[[", "]]" },
    input = { "l" },
    filetype = { "markdown" },
  },
  {
    buns = { "[", "]()" },
    input = { "L" },
    filetype = { "markdown" },
  },
})

vim.cmd([[
let g:textobj_sandwich_no_default_key_mappings = 1
]])
