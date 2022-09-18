vim.g.coc_global_extensions = {
  'coc-browser',
  'coc-calc',
  'coc-css',
  'coc-cssmodules',
  'coc-diagnostic',
  'coc-dictionary',
  'coc-docker',
  'coc-eslint',
  'coc-html',
  'coc-jest',
  'coc-json',
  'coc-lists',
  'coc-neosnippet',
  'coc-prettier',
  'coc-sh',
  'coc-solargraph',
  'coc-sourcekit',
  'coc-sql',
  'coc-sumneko-lua',
  'coc-syntax',
  'coc-translator',
  'coc-tsserver',
  'coc-vimlsp',
  'coc-webpack',
  'coc-xml',
  'coc-word',
  'coc-yaml'
}

vim.cmd([[
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn <Plug>(coc-rename)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" popup
nmap <Leader>ctl <Plug>(coc-translator-p)
vmap <Leader>ctl <Plug>(coc-translator-pv)
" echo
nmap <Leader>cte <Plug>(coc-translator-e)
vmap <Leader>cte <Plug>(coc-translator-ev)
" replace
nmap <Leader>ctr <Plug>(coc-translator-r)
vmap <Leader>ctr <Plug>(coc-translator-rv)

let g:coc_status_error_sign = 'E:'
let g:coc_status_warning_sign = 'W:'
]])
