let g:neoterm_autoinsert = 1
let g:neoterm_autoscroll = 1
let g:neoterm_default_mod = "belowright"

function! NTermHolizontalSplit()
  let l:tmp = g:neoterm_default_mod
  let g:neoterm_default_mod = "botright"
  Tnew
  let g:neoterm_default_mod = l:tmp
endfunction

function! NTermVerticalSplit()
  let l:tmp = g:neoterm_default_mod
  let g:neoterm_default_mod = "vertical"
  Tnew
  let g:neoterm_default_mod = l:tmp
endfunction

let g:neoterm_automap_keys=''

nnoremap <silent><Leader>nt :Ttoggle<CR>
nnoremap <silent><Leader>nh :call NTermHolizontalSplit()<CR>
nnoremap <silent><Leader>nv :call NTermVerticalSplit()<CR>
