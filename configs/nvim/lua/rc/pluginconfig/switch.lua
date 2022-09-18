vim.cmd([[
let g:switch_mapping = '\'

autocmd FileType swift let b:switch_custom_definitions =
  \ [
  \   [ 'XCTAssertTrue', 'XCTAssertFalse' ],
  \   [ 'XCTAssertNil', 'XCTAssertNotNil' ],
  \   { 'private var': 'var' },
  \   { '\%(private \)\@<!var': 'private var' }
  \ ]
]])
