vim.g.netrw_nogx = 1 -- disable netrw's gx mapping.

vim.keymap.set({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)", { remap = true })
