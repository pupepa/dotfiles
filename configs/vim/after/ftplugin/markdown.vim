" forked from http://qiita.com/naoty_k/items/56eddc9b76fe630f9be7

" Pandoc で docx に変換した時にリストのインデントが 4 でないと正しく階層化されない
setlocal tabstop=4         " タブサイズ
setlocal shiftwidth=4      " シフト移動幅
setlocal conceallevel=0

" todoリストを簡単に入力する
abbreviate tl - [ ]

" 入れ子のリストを折りたたむ
setlocal foldmethod=expr foldexpr=MkdCheckboxFold(v:lnum) foldtext=MkdCheckboxFoldText()

function! MkdCheckboxFold(lnum)
    let line = getline(a:lnum)
    let next = getline(a:lnum + 1)
    if MkdIsNoIndentCheckboxLine(line) && MkdHasIndentLine(next)
        return 1
    elseif (MkdIsNoIndentCheckboxLine(next) || next =~ '^$') && !MkdHasIndentLine(next)
        return '<1'
    endif

    if MkdHasIndentLine(line)
      return 1
    elseif line != line('$') && next =~ ''
      return '<1'
    endif

    return '='
endfunction

function! MkdIsNoIndentCheckboxLine(line)
    return a:line =~ '^- \[[ x]\] '
endfunction

function! MkdHasIndentLine(line)
    return a:line =~ '^[[:blank:]]\+'
endfunction

function! MkdCheckboxFoldText()
    return getline(v:foldstart) . ' (' . (v:foldend - v:foldstart) . ' lines) '
endfunction

function! MkdIsHeaderLine(line)
  return a:line =~ '^#*'
endfunction

" todoリストのon/offを切り替える
nnoremap <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>
vnoremap <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>

" 選択行のチェックボックスを切り替える
function! ToggleCheckbox()
  let l:line = getline('.')
  if l:line =~ '\-\s\[\s\]'
    let l:result = substitute(l:line, '-\s\[\s\]', '- [x]', '')
    call setline('.', l:result)
  elseif l:line =~ '\-\s\[x\]'
    let l:result = substitute(l:line, '-\s\[x\]', '- [ ]', '')
    call setline('.', l:result)
  end
endfunction

syn match MkdCheckboxMark /-\s\[x\]\s.\+/ display containedin=ALL
hi MkdCheckboxMark ctermfg=green
syn match MkdCheckboxUnmark /-\s\[\s\]\s.\+/ display containedin=ALL
hi MkdCheckboxUnmark ctermfg=red
