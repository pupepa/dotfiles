if exists("b:did_ftplugin_todo")
  finish
endif
let b:did_ftplugin_todo = 1

highlight TodoPriorityA ctermfg=1 guifg=Red
highlight TodoPriorityB ctermfg=3 guifg=Orange
highlight TodoPriorityC ctermfg=12 guifg=DarkYellow
highlight TodoPriorityD ctermfg=10 guifg=Gray

" Other priority colours might be defined by the user
highlight!  default  link  TodoKey        Normal
highlight!  default  link  TodoDone       Comment
highlight!  default  link  TodoDate       Identifier
highlight!  default  link  TodoProject    Identifier
highlight!  default  link  TodoContext    Statement
highlight!  default  link  TodoDueToday   PreProc

function! DoToggleMarkAsDoneWithSort() abort
  let l:line = line(".")
  silent! call todo#ToggleMarkAsDone('')
  silent! sort
  silent! call todo#SortDue()
  call cursor(l:line, 0)
endfunction

nnoremap <buffer> <script> <silent> <Leader><Leader> :call DoToggleMarkAsDoneWithSort()<CR>
nnoremap <script> <silent> <buffer> <Plug>(todo-sort-and-sortdue) :silent! sort<CR>
            \:silent! call todo#SortDue()<CR>
nmap <buffer> <Leader>so <Plug>(todo-sort-and-sortdue)

function! InsertTodoSeparator(start_date, num)
  let i = 0
  let list = []

  while i < a:num
    let date = localtime() + ((60 * 60 * 24) * (a:start_date + i))
    call add(list, "(A) !" . strftime("%Y-%m-%d (%a)", date) . " --------------------------------------------------------------- due:" . strftime("%Y-%m-%d", date))
    let i += 1
  endwhile

  call append(line("."), list)
  " echo ret
endfunction
command! -nargs=* InsertTodoSeparator call InsertTodoSeparator(<f-args>)

" due をインクリメントする
function! IncrementDueDate()
  let l:current_pos = getpos('.')
  call setpos('.', [l:current_pos[0], l:current_pos[1], 0, l:current_pos[3]])
  call search('due:\d\{4}-\d\{2}-\d\{2}', 'e')
  call feedkeys('l')
  call speeddating#increment(v:count == 0 ? 1 : v:count)
  call setpos('.', l:current_pos)
endfunction

command! -nargs=? -count IncrementDueDate call IncrementDueDate()

nnoremap <buffer> <script> <silent> <Leader>da :IncrementDueDate<CR>
