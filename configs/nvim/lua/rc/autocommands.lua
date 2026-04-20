local group_name = "vimrc_vimrc"

vim.api.nvim_create_augroup(group_name, { clear = true })

-- ヤンクした時にハイライトする
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = group_name,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Substitute", timeout = 300 })
  end,
  once = false,
})

local restore_cursor_group = "restore_cursor"

vim.api.nvim_create_augroup(restore_cursor_group, { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = restore_cursor_group,
  callback = function()
    if vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) <= vim.fn.line("$") then
      vim.cmd('normal! g`" | zv')
    end
  end,
})

vim.cmd([[
  command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
]])

-- 先頭大文字のスペルチェックのハイライトをオフにする
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = group_name,
  pattern = "*",
  callback = function()
    vim.cmd([[hi clear SpellCap]])
  end,
  once = true,
})

-- AIによるコミットメッセージ生成 (<Leader>ai: 英語, <Leader>aj: 日本語)
if vim.fn.executable("claude") == 1 then
  local function generate_commit_message(prompt)
    local bufnr = vim.api.nvim_get_current_buf()
    local output = {}

    vim.notify("コミットメッセージを生成中...", vim.log.levels.INFO)

    vim.fn.jobstart("git diff --cached | claude --no-session-persistence --print --model haiku '" .. prompt .. "'", {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          vim.list_extend(output, data)
        end
      end,
      on_exit = function(_, exit_code)
        vim.schedule(function()
          if exit_code == 0 then
            local result = vim.trim(table.concat(output, "\n"))
            if result ~= "" and vim.api.nvim_buf_is_valid(bufnr) then
              vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { result })
              vim.api.nvim_win_set_cursor(0, { 1, 0 })
              vim.notify("コミットメッセージを挿入しました", vim.log.levels.INFO)
            end
          else
            vim.notify("コミットメッセージの生成に失敗しました", vim.log.levels.ERROR)
          end
        end)
      end,
    })
  end

  local gitcommit_ai_group = "gitcommit_ai"

  vim.api.nvim_create_augroup(gitcommit_ai_group, { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = gitcommit_ai_group,
    pattern = "gitcommit",
    callback = function()
      vim.keymap.set("n", "<Leader>ai", function()
        generate_commit_message(
          "Generate ONLY a one-line Git commit message following Conventional Commits format "
            .. "(type(scope): description). Types: feat, fix, docs, style, refactor, test, chore. "
            .. "Based strictly on the diff from stdin. Output ONLY the message, nothing else."
        )
      end, { buffer = true, desc = "AI commit message (English)" })

      vim.keymap.set("n", "<Leader>aj", function()
        generate_commit_message(
          "Generate ONLY a one-line Git commit message in Japanese following Conventional Commits format "
            .. "(type(scope): 日本語の説明). Types: feat, fix, docs, style, refactor, test, chore. "
            .. "Based strictly on the diff from stdin. Output ONLY the message, nothing else."
        )
      end, { buffer = true, desc = "AI commit message (Japanese)" })
    end,
  })
end

--- .env.* は filetype を sh にする
local dotenv_group = "filetype_dotenv"
vim.api.nvim_create_augroup(dotenv_group, { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = dotenv_group,
  pattern = ".env.*",
  callback = function()
    vim.bo.filetype = "sh"
  end,
})
