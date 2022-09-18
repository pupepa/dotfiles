if !isdirectory(g:plug_home . '/copilot.vim') || !has('nvim')
  finish
endif

imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

let g:copilot_filetypes = {
  \ 'markdown': v:false,
  \ 'text': v:false,
  \ 'xml': v:false,
  \ }
