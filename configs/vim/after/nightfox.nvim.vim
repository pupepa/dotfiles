if !isdirectory(g:plug_home . '/nightfox.nvim') || !has('nvim')
  finish
endif

colorscheme nightfox
set background=dark

function! CreateSymlinkForWezTerm()
  let l:wezterm_colors_path = $XDG_CONFIG_HOME . '/wezterm/colors'
  if !isdirectory(l:wezterm_colors_path)
    call mkdir(l:wezterm_colors_path, 'p')
  endif

  let l:wezterm_color_scheme_filename = 'nightfox_wezterm.toml'
  let l:wezterm_color_scheme_path = $XDG_CONFIG_HOME . '/nvim/plugged/nightfox.nvim/extra/nightfox/' . l:wezterm_color_scheme_filename
  if !filereadable(l:wezterm_colors_path . '/' . l:wezterm_color_scheme_filename)
    call system('ln -s ' . l:wezterm_color_scheme_path . ' ' . l:wezterm_colors_path . '/' . l:wezterm_color_scheme_filename)
    echom 'Create symlink for wezterm colorscheme'
  endif
endfunction
