setlocal tabstop=2 shiftwidth=2 softtabstop=2

augroup rubyabbr
    autocmd!
    autocmd FileType ruby iabbrev require require
augroup END
