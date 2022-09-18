if !isdirectory(g:plug_home . '/lightline.vim')
  finish
endif

function! LightlineBufferline()
  call bufferline#refresh_status()
  return [g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

function! LightlineFugitive()
  if exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFilename()
  return '' != expand('%:t') ? expand('%:t') : '[No Name]'
endfunction

function! LightlineLSPWarnings() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  return l:counts.warning == 0 ? '' : printf('W:%d', l:counts.warning)
endfunction

function! LightlineLSPErrors() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  return l:counts.error == 0 ? '' : printf('E:%d', l:counts.error)
endfunction

function! LightlineLSPOk() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:total = l:counts.error + l:counts.warning
  return l:total == 0 ? 'OK' : ''
endfunction     \ }

function! LightlinePwd() abort
  return winwidth(0) - len(getcwd()) < 50 ? '' : getcwd()
endfunction     \ }

let g:lightline = {
      \ 'background': 'dark',
      \ 'colorscheme': 'solarized_patch',
      \ 'tabline': {
      \   'left': [ ['buffers'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel',
      \ },
      \ 'mode_mop': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename', 'readonly', 'modified' ],
      \             [ 'pwd' ],
      \           ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ],
      \            ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'pwd': 'LightlinePwd'
      \ },
      \ }

if has('nvim')
  call add(g:lightline['active']['left'][1], 'cocstatus')
  let g:lightline['component_function']['cocstatus'] = 'coc#status'
else
  let g:lightline['component_expand']['lsp_warnings'] = 'LightlineLSPWarnings'
  let g:lightline['component_expand']['lsp_errors'] = 'LightlineLSPErrors'
  let g:lightline['component_expand']['lsp_ok'] = 'LightlineLSPOk'

  let g:lightline['component_type']['lsp_warnings'] = 'warning'
  let g:lightline['component_type']['lsp_errors'] = 'error'
  let g:lightline['component_type']['lsp_ok'] = 'right'

  call extend(g:lightline['active']['left'][1], [ 'lsp_errors', 'lsp_warnings', 'lsp_ok' ])
endif

if isdirectory(g:plug_home . '/vim-anzu')
  let g:lightline['component_function']['anzu'] = 'anzu#search_status'
  call add(g:lightline['active']['left'][1], 'anzu')
endif

if isdirectory(g:plug_home . '/vista.vim')
  let g:lightline['component_function']['method'] = 'NearestMethodOrFunction'
  call add(g:lightline['active']['left'][2], 'method')
endif

augroup LightLineOnLSP
  autocmd!
  autocmd User lsp_diagnostics_updated call lightline#update()
augroup END
