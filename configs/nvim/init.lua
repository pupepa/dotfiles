require("rc/base")
require("rc/autocommands")
require("rc/commands")
require("rc/mappings")
require("rc/option")
require("rc/terminal")
require("rc/pluginlist")
-- 環境に応じてClaude Code統合モジュールを選択
if vim.env.WEZTERM_PANE then
  require("modules.cc-wezterm").setup()
elseif vim.env.TMUX then
  require("modules.cc").setup()
end
