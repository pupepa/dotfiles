local wezterm = require("wezterm")
local io = require("io")
local os = require("os")

-- モジュールテーブルを作成
local module = {}

-- イベントハンドラを設定
wezterm.on("trigger-vim-with-scrollback", function(window, pane)
  local scrollback = pane:get_lines_as_text()
  local name = os.tmpname()
  local f = io.open(name, "w+")

  if f == nil then
    return
  end

  f:write(scrollback)
  f:flush()
  f:close()

  window:perform_action(
    wezterm.action({
      SpawnCommandInNewTab = {
        args = { "/opt/homebrew/bin/nvim", name },
      },
    }),
    pane
  )
  wezterm.sleep_ms(1000)
  os.remove(name)
end)

-- configにキーバインドを適用する関数
function module.apply_to_config(config)
  if not config.keys then
    config.keys = {}
  end

  table.insert(config.keys, {
    key = "E",
    mods = "CTRL|SHIFT",
    action = wezterm.action({ EmitEvent = "trigger-vim-with-scrollback" }),
  })
end

return module
