require("tabout").setup({
  tabkey = "<Tab>",
  backwards_tabkey = "<S-Tab>",
  ignore_beginning = true,
  act_as_tab = true,
  enable_backwards = true,
  completion = true,
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = "`", close = "`" },
    { open = "(", close = ")" },
    { open = "[", close = "]" },
    { open = "{", close = "}" },
    { open = "「", close = "」" },
  },
  exclude = {},
})
