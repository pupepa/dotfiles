vim.cmd([[
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

augroup vista_vimrc
  autocmd!
  autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
augroup end

let g:vista_update_on_text_changed = 1

if has('nvim')
  let g:vista_executive_for = {
        \ 'swift': 'coc',
        \ 'ruby': 'coc',
        \ 'typescript': 'coc',
        \ 'typescriptreact': 'coc',
        \ }
else
  let g:vista_executive_for = {
        \ 'swift': 'vim_lsp',
        \ 'ruby': 'vim_lsp',
        \ 'typescript': 'vim_lsp',
        \ 'typescriptreact': 'vim_lsp',
        \ }
end

nnoremap <Space>v :<C-u>Vista finder<CR>
]])
