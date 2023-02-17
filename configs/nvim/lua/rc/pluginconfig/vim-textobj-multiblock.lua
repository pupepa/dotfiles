vim.cmd([[
let g:textobj_multiblock_blocks = [
     \      [ '`', '`', 1],
     \      [ '（', '）' ],
     \      [ '「', '」' ],
     \      [ '『', '』' ],
     \      [ '【', '】' ],
     \ ]

omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
vmap ab <Plug>(textobj-multiblock-a)
vmap ib <Plug>(textobj-multiblock-i)
]])
