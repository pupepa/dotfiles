export LANG=ja_JP.UTF-8
export SHELL='zsh'

if [ $commands[nvim] ]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

bindkey -e

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share:$HOME/.config/bin:/opt/homebrew/bin:$HOME/.local/bin:$PATH$

HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000

setopt share_history

setopt AUTO_CD

# 単語の区切り設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-chars unspecified

# for notmuch
export XAPIAN_CJK_NGRAM=1

autoload -Uz colors; colors

set -o emacs

########################################
# 補完
########################################

# 補完機能を有効にする
autoload -Uz compinit; compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

compinit -d "${ZSH_COMPDUMP}"
