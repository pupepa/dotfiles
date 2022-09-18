if !isdirectory(g:plug_home . '/vim-textobj-multiblock')
  finish
endif

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
