local wezterm = require("wezterm")
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

local module = {}

-- 保存先を安定したパスに固定する。
-- プラグインの既定保存先はプラグインディレクトリ内 (更新時に消える) ため上書きする。
local save_dir = wezterm.home_dir .. "/.local/share/wezterm/resurrect/"

function module.apply_to_config(config)
  if not config.keys then
    config.keys = {}
  end

  resurrect.state_manager.change_state_save_dir(save_dir)

  -- 数分ごとの自動保存 (ワークスペース/ウィンドウ単位を定期保存)
  resurrect.state_manager.periodic_save({
    interval_seconds = 300,
    save_workspaces = true,
    save_windows = true,
    save_tabs = false,
  })

  -- 手動保存: Leader + s (現在のウィンドウ状態を保存)
  -- 注: プラグインの save_window_action() は内部で require("resurrect") を呼ぶが、
  -- 当該モジュールが存在せず失敗する (アーカイブ済みプラグインのバグ)。
  -- そのため挙動を再現しつつ、モジュールハンドル経由で直接保存する。
  table.insert(config.keys, {
    key = "s",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      local mux_win = win:mux_window()
      if mux_win:get_title() == "" then
        -- ウィンドウ名が未設定なら保存名を尋ねる (ファイル名のキーになる)
        win:perform_action(
          wezterm.action.PromptInputLine({
            description = "保存するウィンドウ名を入力",
            action = wezterm.action_callback(function(window, _, title)
              if title and title ~= "" then
                window:mux_window():set_title(title)
                resurrect.state_manager.save_state(
                  resurrect.window_state.get_window_state(window:mux_window())
                )
              end
            end),
          }),
          pane
        )
      else
        resurrect.state_manager.save_state(resurrect.window_state.get_window_state(mux_win))
        win:toast_notification("resurrect", "ウィンドウ状態を保存しました", nil, 2000)
      end
    end),
  })

  -- 復元: Leader + r (fuzzy finder で保存済みから選択 → 現在のウィンドウに復元)
  table.insert(config.keys, {
    key = "R",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, _)
        local type = string.match(id, "^([^/]+)")
        id = string.match(id, "([^/]+)$")
        id = string.match(id, "(.+)%..+$")

        local opts = {
          window = win:mux_window(),
          relative = true,
          restore_text = false, -- スクロールバック (ヒストリー) は復元しない
          close_open_tabs = true, -- 起動時の初期タブを閉じてタブのズレを防ぐ
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        }

        if type == "window" then
          local state = resurrect.state_manager.load_state(id, "window")
          resurrect.window_state.restore_window(pane:window(), state, opts)
        elseif type == "workspace" then
          local state = resurrect.state_manager.load_state(id, "workspace")
          resurrect.workspace_state.restore_workspace(state, opts)
        end
      end)
    end),
  })
end

return module
