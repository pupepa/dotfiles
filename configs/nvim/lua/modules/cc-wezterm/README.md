# Claude Code WezTerm統合モジュール

NeovimからWezTermペインでClaude Codeを操作するためのモジュールです。

## 機能

- `:Claude`コマンドでWezTermペインにClaude Codeを起動
- Neovimの入力バッファでメッセージを作成し、`<CR>`でClaude Codeに送信
- ペインの自動検索・再利用
- キーバインドによる便利な操作

## 要件

- WezTerm
- Neovim 0.7+
- Claude Code CLI (`claude`)

## 使い方

### コマンド

```vim
:Claude          " Claude Codeを起動
:Claude -r       " Claude Codeを-rオプション付きで起動
:Claude -c       " Claude Codeを-cオプション付きで起動
```

### キーマップ

| キー | 説明 |
|------|------|
| `<leader>ac` | Claude Codeを起動 |
| `<leader>ar` | Claude Codeを-rオプション付きで起動 |
| `<leader>aC` | Claude Codeを-cオプション付きで起動 |

### 入力バッファ内のキーマップ

| キー | 説明 |
|------|------|
| `<CR>` (ノーマルモード) | テキストをClaude Codeに送信してバッファを閉じる |
| `q` | バッファを閉じる（変更がある場合は警告） |
| `<C-x><C-x>` | Claude Codeペインを終了 |

## アーキテクチャ

```
cc-wezterm/
├── init.lua      # メインモジュール（コマンド登録、ペイン管理）
├── wezterm.lua   # WezTerm CLI wrapper（低レベルAPI）
└── buffer.lua    # バッファ管理（入力UI）
```

## tmux版との違い

WezTerm版では以下の機能が省略されています：

- ペインのスクロール操作（`<C-d>`, `<C-u>`, `<C-n>`, `<C-p>`）
  - WezTermのCLIにスクロール制御機能がないため
  - 手動でスクロール（`Shift+PageUp/Down`）してください

- Shift+Tab送信（`<S-Tab>`）
  - WezTermのCLIに特殊キー送信機能がないため

## トラブルシューティング

### "このコマンドはWezTermセッション内でのみ使用できます"

WezTerm内で実行していることを確認してください。環境変数`WEZTERM_PANE`が設定されている必要があります。

```bash
echo $WEZTERM_PANE  # ペインIDが表示されるはず
```

### ペインが見つからない

既存のClaude Codeペインがメモリにないか、終了済みの可能性があります。`:Claude`を再実行すると新しいペインが作成されます。

### テキスト送信が失敗する

- ペインが存在するか確認（`wezterm cli list`）
- Claude Codeが正しく起動しているか確認

## 開発

### デバッグ

```lua
-- wezterm.luaにデバッグ出力を追加
vim.notify(vim.inspect(result), vim.log.levels.DEBUG)
```

### テスト

```bash
# WezTerm CLI動作確認
wezterm cli list --format json

# ペイン作成テスト
wezterm cli split-pane --right --percent 30 -- claude

# テキスト送信テスト
echo "Hello" | wezterm cli send-text --pane-id <pane_id> --no-paste
```
