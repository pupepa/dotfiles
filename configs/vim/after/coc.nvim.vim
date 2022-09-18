if !isdirectory(g:plug_home . '/coc.nvim')
  finish
endif

let g:coc_global_extensions =
      \ ['coc-browser',
      \ 'coc-calc',
      \ 'coc-css',
      \ 'coc-cssmodules',
      \ 'coc-diagnostic',
      \ 'coc-dictionary',
      \ 'coc-docker',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-jest',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-lua',
      \ 'coc-neosnippet',
      \ 'coc-pairs',
      \ 'coc-prettier',
      \ 'coc-sh',
      \ 'coc-solargraph',
      \ 'coc-sourcekit',
      \ 'coc-sql',
      \ 'coc-syntax',
      \ 'coc-translator',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-webpack',
      \ 'coc-xml',
      \ 'coc-word',
      \ 'coc-yaml']

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm():
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-r>=lexima#expand('<lt>CR>', 'i')\<CR>\<C-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn <Plug>(coc-rename)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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
