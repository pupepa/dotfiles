vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ":", ";")

-- Buffer Operation
vim.keymap.set("n", "[b", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "]b", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "[B", ":bfirst<CR>", { silent = true })
vim.keymap.set("n", "]B", ":blast<CR>", { silent = true })
vim.keymap.set("n", "<Leader>bu", ":b #<CR>", { silent = true })

-- Window
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("n", "sH", "<C-w>H")
vim.keymap.set("n", "sJ", "<C-w>J")
vim.keymap.set("n", "sK", "<C-w>K")
vim.keymap.set("n", "sL", "<C-w>L")
vim.keymap.set("n", "sc", ":close<CR>")
vim.keymap.set("n", "ss", ":<C-u>split<CR>")
vim.keymap.set("n", "sv", ":<C-u>vs<CR>")
vim.keymap.set("n", "so", "<C-w>o")
vim.keymap.set("n", "sx", "<C-w>x")
vim.keymap.set("n", "s]", "gt")
vim.keymap.set("n", "s[", "gT")
vim.keymap.set("n", "s=", "<C-w>=")

vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>")

-- Open init.lua
vim.keymap.set("n", "<Space>.", ":<C-u>edit $MYVIMRC<CR>")

vim.keymap.set("n", "ZZ", "<Nop>")

-- Use better-escape
-- vim.keymap.set("i", "jj", "<Esc>")

-- Quickfix
vim.keymap.set("n", "Q", "q")
vim.keymap.set("n", "q", "<NOP>")
vim.keymap.set("n", "]q", ":cnext<CR>")
vim.keymap.set("n", "[q", ":cNext<CR>")

-- Split window by tmux
vim.cmd([[ nnoremap <Leader>tv :!tmux splitw -h -c %:p:h <CR><CR> ]])
vim.cmd([[ nnoremap <Leader>th :!tmux splitw -vf -c %:p:h <CR><CR> ]])

-- Look up a keyword on cursor with help
vim.keymap.set("n", "<Leader>hh", ':h <C-r>=expand("<cword>")<CR><CR>')

-- Paste path when command line mode
vim.keymap.set("c", "<C-x>", "<C-r>=expand('%:p')<CR>")

-- " 0 と ^ を意識しない
vim.keymap.set("n", "0", function()
  return string.match(vim.fn.getline("."):sub(0, vim.fn.col(".") - 1), "^%s+$") and "0" or "^"
end, { expr = true, silent = true })

vim.keymap.set({ "n", "v" }, "<Space>j", "10j")
vim.keymap.set({ "n", "v" }, "<Space>k", "10k")

-- Do not set register
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')

-- " インサートモードで <C-a> <C-e> で行頭と行末にそれぞれ移動
vim.keymap.set("i", "<C-a>", "<C-o>^")
vim.keymap.set("i", "<C-e>", "<C-o>$")

-- インサートモード時のインデントが Tmux の Prefix と同じなので変更
-- <C-f> is a prefix for tmux
vim.keymap.set("i", "<C-f>", "<C-t>")

-- Commands
vim.keymap.set("n", "<Leader>r", ":NumberToggle<CR>")

-- ファイル名を表示
vim.keymap.set("n", "<Leader>pp", ':<C-u>echo expand("%:p")<CR>')

-- 開いているファイルのディレクトリに移動
vim.keymap.set("n", "<Leader>lc", ":<C-u>lcd %:h<CR>", { silent = true })

-- 空行
vim.keymap.set("n", "<Space><Space>", ":<C-u>put =repeat(nr2char(10), v:count1)<CR>")
