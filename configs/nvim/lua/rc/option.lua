vim.opt.cmdheight = 0
vim.opt.pumheight = 10   -- 補完メニューの高さ
vim.opt.history = 10000
vim.opt.helplang = "ja"

-- Timeout
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 10 -- Normal モードへの切り替えの遅延をなくす

-- Tab
vim.opt.tabstop = 2      -- タブサイズ
vim.opt.shiftwidth = 2   -- シフト移動幅
vim.opt.expandtab = true -- タブの代わりに空白文字を挿入する
vim.opt.smarttab = true  -- 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。

-- Clipboard
if vim.fn.has("clipboard") == 1 then
  vim.opt.clipboard = "unnamedplus,unnamed"
end

-- Insert
vim.opt.backspace = "indent,eol,start" -- バックスペースでインデントや改行を削除できるようにする
vim.opt.formatoptions:append("m")
vim.opt.formatoptions:append("M")

-- Command
vim.opt.wildmenu = true       -- コマンドライン補完を拡張
vim.opt.wildignorecase = true -- 補完の時に大文字小文字を無視する
vim.opt.wildignore = "*.pyc,*.o,*.lo,*.la,*.exe,*.swp,*.db,*.bak,*.old,*.dat,*.,tmp,*.mdb,*~,~*"

-- Search
vim.opt.wrapscan = false  -- 検索をファイルの先頭へループしない
vim.opt.ignorecase = true -- 検索時の大文字小文字を区別しない
vim.opt.smartcase = true  -- 検索文字列に大文字小文字の両方が含まれる場合、区別する
vim.opt.incsearch = true  -- インクリメンタルサーチを行う
vim.opt.hlsearch = true

-- Window
vim.opt.splitbelow = true

-- File
vim.opt.hidden = true       -- バッファを保存せずに切り替える
vim.opt.backup = false      -- for coc.nvim
vim.opt.writebackup = false -- for coc.nvim
vim.opt.swapfile = false

-- Display
vim.g.colorterm = os.getenv("COLORTERM")
if vim.fn.exists("+termguicolors") == 1 then
  vim.o.termguicolors = true
end

vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.opt.synmaxcol = 200

vim.cmd([[ syntax enable ]])
vim.opt.background = "dark"

vim.opt.ambiwidth = "single"
vim.opt.cursorline = true
vim.opt.display = "lastline" -- 1 行の文字数が多くても表示
vim.opt.foldenable = false   -- 折りたたみを使用しない
vim.opt.signcolumn = "yes"   -- SignColumn を常に表示
vim.opt.lazyredraw = true    -- 再描画のタイミングを遅らせてスクロール速度を速くする
vim.opt.showmatch = true     -- 括弧を入力した時に対応する括弧へ一瞬ジャンプする
vim.opt.number = true
vim.opt.matchtime = 1        -- showmatch の秒数
vim.opt.list = true          -- タブ文字、行末など不可視文字を表示する
vim.opt.showmode = false     -- インサートモードなどの文字を非表示にする
vim.opt.laststatus = 3       -- 下部のステータスラインを常に表示
vim.opt.showtabline = 2      -- タブページを常に表示

-- Bell
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Complete
vim.opt.complete:append("kspell")
vim.opt.completeopt = "menuone,noselect"
vim.opt.spell = true
vim.opt.spelllang = "en,cjk"

-- Undo
vim.opt.undofile = true
local undodir = vim.fn.expand("$HOME/.cache/nvim/undodir")
vim.opt.undodir = undodir
vim.fn.mkdir(undodir, "p")

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

vim.g.markdown_fenced_languages =
{ "ruby", "python", "sql", "swift", "typescript", "typescriptreact", "javascript", "javascriptreact", "sh" }
