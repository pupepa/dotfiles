vim.cmd([[
let g:rooter_manual_only = 1
let g:rooter_cd_cmd="lcd"
let g:rooter_patterns =
  \ [
  \   '.git/',
  \   'Makefile',
  \   'Rakefile',
  \   'vendor/',
  \   'Podfile',
  \   'package.json',
  \   'package-lock.json',
  \   'README.md',
  \   'node_modules/',
  \   '.ruby-version'
  \ ]
]])
