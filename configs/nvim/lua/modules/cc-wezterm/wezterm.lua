-- WezTerm操作の低レベルAPI
-- このモジュールは外部状態を持たず、純粋にwezterm cliコマンドのラッパーとして機能する

local M = {}

-- WezTermセッション内で実行されているかチェック
-- @return boolean WezTermセッション内ならtrue
function M.is_in_wezterm()
  return vim.env.WEZTERM_PANE ~= nil and vim.env.WEZTERM_PANE ~= ""
end

-- weztermコマンドを実行してエラーハンドリング
-- @param cmd string weztermコマンド
-- @return string|nil, string|nil 成功時は (出力, nil)、失敗時は (nil, エラーメッセージ)
local function exec_wezterm(cmd)
  local result = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    local error_msg = string.format(
      "wezterm command failed (exit code: %d)\nCommand: %s\nOutput: %s",
      vim.v.shell_error,
      cmd,
      vim.trim(result)
    )
    return nil, error_msg
  end
  return vim.trim(result), nil
end

-- 新規ペインを作成（現在のペインを横分割）
-- @param size_percent number 新規ペインのサイズ（%）
-- @param shell_command string|nil 実行するコマンド（省略時は通常のシェル）
-- @return string|nil, string|nil 成功時は (ペインID, nil)、失敗時は (nil, エラーメッセージ)
function M.create_pane(size_percent, shell_command)
  -- --right: 右側に分割
  -- --percent: サイズ指定（パーセンテージ）
  -- コマンド出力としてペインIDが返される
  local cmd
  if shell_command then
    -- コマンドを指定する場合
    local escaped_cmd = shell_command:gsub("'", "'\\''")
    cmd = string.format("wezterm cli split-pane --right --percent %d -- sh -c '%s'", size_percent, escaped_cmd)
  else
    cmd = string.format("wezterm cli split-pane --right --percent %d", size_percent)
  end

  local output, err = exec_wezterm(cmd)
  if not output then
    return nil, err
  end

  -- 出力からペインIDを抽出（例: "37"）
  local pane_id = vim.trim(output)
  if not pane_id:match("^[0-9]+$") then
    return nil, "Failed to parse pane ID from output: " .. output
  end

  return pane_id, nil
end

-- ペインが存在するかチェック
-- @param pane_id string ペインID（例: "37"）
-- @return boolean 存在すればtrue
function M.pane_exists(pane_id)
  local cmd = "wezterm cli list --format json"
  local result, _ = exec_wezterm(cmd)
  if not result then
    return false
  end

  -- JSONをパース
  local ok, panes = pcall(vim.fn.json_decode, result)
  if not ok then
    return false
  end

  for _, pane in ipairs(panes) do
    if tostring(pane.pane_id) == tostring(pane_id) then
      return true
    end
  end
  return false
end

-- 現在のタブ内で特定のコマンドを実行しているペインを検索
-- @param pattern string コマンド名のパターン（部分一致）
-- @return string|nil ペインID、見つからない場合はnil
function M.find_pane_by_command(pattern)
  local cmd = "wezterm cli list --format json"
  local result, _ = exec_wezterm(cmd)
  if not result then
    return nil
  end

  -- JSONをパース
  local ok, panes = pcall(vim.fn.json_decode, result)
  if not ok then
    return nil
  end

  -- 現在のタブIDを取得
  local current_pane_id = vim.env.WEZTERM_PANE
  local current_tab_id = nil
  for _, pane in ipairs(panes) do
    if tostring(pane.pane_id) == current_pane_id then
      current_tab_id = pane.tab_id
      break
    end
  end

  if not current_tab_id then
    return nil
  end

  -- 同じタブ内でtitleにパターンが含まれるペインを検索
  for _, pane in ipairs(panes) do
    if pane.tab_id == current_tab_id and pane.title and pane.title:find(pattern, 1, true) then
      return tostring(pane.pane_id)
    end
  end
  return nil
end

-- ペインにテキストを送信
-- @param pane_id string ペインID
-- @param text string 送信するテキスト
-- @return boolean, string|nil 成功時は (true, nil)、失敗時は (false, エラーメッセージ)
function M.send_text(pane_id, text)
  -- テキストを一時ファイルに書き込んで送信（シェルエスケープを避けるため）
  local tmpfile = vim.fn.tempname()
  local f = io.open(tmpfile, "w")
  if not f then
    return false, "Failed to create temporary file"
  end
  f:write(text)
  f:close()

  local cmd = string.format("wezterm cli send-text --pane-id %s --no-paste < %s", pane_id, tmpfile)
  local _, err = exec_wezterm(cmd)
  vim.fn.delete(tmpfile)

  if err then
    return false, err
  end

  -- Enterキーを送信（改行を送る）
  -- printfを使って改行文字を送信
  cmd = string.format("printf '\r' | wezterm cli send-text --pane-id %s --no-paste", pane_id)
  _, err = exec_wezterm(cmd)
  if err then
    return false, err
  end

  return true, nil
end

-- 現在のペインのIDを取得
-- @return string|nil, string|nil 成功時は (ペインID, nil)、失敗時は (nil, エラーメッセージ)
function M.get_current_pane()
  local pane_id = vim.env.WEZTERM_PANE
  if pane_id and pane_id ~= "" then
    return pane_id, nil
  end
  return nil, "WEZTERM_PANE environment variable not set"
end

-- ペインを強制終了
-- @param pane_id string ペインID
-- @return boolean, string|nil 成功時は (true, nil)、失敗時は (false, エラーメッセージ)
function M.kill_pane(pane_id)
  local cmd = string.format("wezterm cli kill-pane --pane-id %s", pane_id)
  local _, err = exec_wezterm(cmd)
  if err then
    return false, err
  end
  return true, nil
end

return M
