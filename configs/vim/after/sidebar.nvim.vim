if !isdirectory(g:plug_home . '/sidebar.nvim') || !has('nvim')
  finish
endif

lua <<EOF

require("sidebar-nvim").setup({
  bindings = { ["q"] = function() require("sidebar-nvim").close() end },
  datetime = {
      icon = "",
      format = "%Y-%m-%d(%a) %H:%M",
  }
})

vim.api.nvim_set_keymap("n", "<Leader>ss", "<Cmd>SidebarNvimToggle<CR>", { noremap = true, silent = true })

EOF
