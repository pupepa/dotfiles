# 外観モード (ダーク)
defaults write NSGlobalDomain AppleInterfaceStyle Dark

################################################################################
# Dock
################################################################################

# サイズ
defaults write com.apple.dock tilesize -int 30

# 拡大
defaults delete com.apple.dock magnification

# 画面上の位置
defaults write com.apple.dock orientation left

# ウインドウをしまうときのエフェクト
defaults write com.apple.dock mineffect scale

# Dockを自動的に表示/非表示
defaults write com.apple.dock autohide -bool true

# Dockに標準で入っているデフォルトアプリを削除
defaults write com.apple.dock persistent-apps -array

killall Dock

################################################################################
# キーボード
################################################################################

# キーのリピート速度
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# スペルチェック
defaults write .GlobalPreferences WebAutomaticSpellingCorrectionEnabled -bool false
defaults write .GlobalPreferences NSAutomaticSpellingCorrectionEnabled -bool false
  
# 文頭を大文字に
defaults write .GlobalPreferences NSAutomaticCapitalizationEnabled -bool false
  
# スペースバーを2回押してピリオドを入力
defaults write .GlobalPreferences NSAutomaticPeriodSubstitutionEnabled -bool false

# スマート引用符とスマートダッシュ
defaults write .GlobalPreferences NSAutomaticDashSubstitutionEnabled -bool false
defaults write .GlobalPreferences NSAutomaticQuoteSubstitutionEnabled -bool false

# Finder

# すべてのファイル名拡張子を表示
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# パスバーを表示
defaults write com.apple.finder "ShowPathbar" -bool "true"

# ステータスバーを表示
defaults write com.apple.finder ShowStatusBar -bool true

# 表示→リスト
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# フォルダを常に先頭に表示
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# 検索実行時: 現在のこのフォルダ内を検索
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

# 「ライブラリ」フォルダを表示
chflags nohidden ~/Library

killall Finder

# 時計

# 時計の書式
defaults write com.apple.menuextra.clock "DateFormat" -string "M\\u6708d\\u65e5(EEE)  H:mm:ss"

# トラックパッド

# 軌跡の速さ
defaults write -g com.apple.trackpad.scaling 3

# タップでクリック
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 1

# 副ボタンのクリック
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad  TrackpadCornerSecondaryClick -int 0

# ナチュラルなスクロール
defaults write .GlobalPreferences com.apple.swipescrolldirection -bool false

# Safari
#

# Show Safari's Status Bar （ステータスバーを表示）
defaults write com.apple.Safari ShowStatusBar -bool true

# アドレスバーに完全なURLを表示
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# その他

# .DS_Storeを作らない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
