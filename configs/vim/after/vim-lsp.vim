if !isdirectory(g:plug_home . '/vim-lsp')
  finish
endif

let g:lsp_log_file = ''

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_text_edit_enabled = 0
let g:lsp_diagnostics_signs_error = {'text': '>>'}
let g:lsp_diagnostics_signs_warning = {'text': '⚠'}
let g:lsp_virtual_text_enabled = 0

let g:lsp_settings = {
    \ 'sourcekit-lsp': {
    \   'cmd': {server_info -> [
    \       'xcrun',
    \       'sourcekit-lsp',
    \       '-Xswiftc',
    \       '-sdk',
    \       '-Xswiftc',
    \       trim(system('xcrun --sdk iphonesimulator --show-sdk-path')),
    \       '-Xswiftc',
    \       '-target',
    \       '-Xswiftc',
    \       join([
    \           'x86_64-apple-ios',
    \           trim(system('xcrun --sdk iphonesimulator --show-sdk-version')),
    \           '-simulator',
    \       ], ''),
    \   ]},
    \   'initialization_options': {'diagnostics': 'true'},
    \ },
    \ 'efm-langserver': {
    \ 'disabled': v:false,
    \ 'allowlist': ['asciidoc', 'markdown', 'swift'],
    \ 'workspace_config': {
    \   'completion': v:false,
    \   'hover': v:false,
    \   'validate': v:true,
    \ }
    \ }
    \ }

let s:efm_config_path = '-c=' .. expand('~/.config/efm-langserver/config.yaml')
let s:efm_log_path = '-log=' .. expand('~/efmlog')

nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gf :LspDocumentFormat<CR>
nnoremap <silent> gh :LspHover<CR>
nnoremap <silent> gr :LspReferences<CR>
nnoremap <silent> gn :LspRename<CR>
nnoremap <silent> ]g :LspNextError<CR>
nnoremap <silent> [g :LspPreviousError<CR>
