vim.cmd([[
nnoremap <Leader>pe :<C-U>MyParteditContext<CR>
xnoremap <Leader>pe :<C-u>PartEdit<CR>
nnoremap <Leader>pq :<C-u>ParteditEnd<CR>

function! s:partedit_context()
    let context = context_filetype#get()
    let startline = context['range'][0][0] ? context['range'][0][0] : 1
    let endline   = context['range'][1][0] ? context['range'][1][0] : '$'
    let filetype  = context['filetype']

    " openerはedit以外は保存時にエラーが出る
    call partedit#start(startline, endline, {'filetype': filetype, 'opener': 'edit'})
endf

command! MyParteditContext call s:partedit_context()
]])
