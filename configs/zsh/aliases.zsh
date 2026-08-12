alias ll='ls -lG'
alias la='ls -laG'

alias rm='trash' # osx-trash
alias cp='cp -i' # -i は確認
alias mv='mv -i' # -i は確認
alias mkdir='mkdir -p' # -p はサブディレクトリごと作成

alias ..='cd ../'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c=clear

alias ta='tig --all'
alias ti='tig'

mktdir() {
  local target_dir="$HOME/tmp/$(date '+%y%m%d')"
  command mkdir -p -- "$target_dir" && builtin cd -- "$target_dir"
}

cdt() {
  local target_dir="$HOME/tmp/$(date '+%y%m%d')"
  command mkdir -p -- "$target_dir" && builtin cd -- "$target_dir"
}

case ${OSTYPE} in
  darwin*)
    alias o='open'
    ;;
esac

if [ -n "$TMUX_PANE" ]; then
  alias fzf='fzf-tmux -p 75%,75%'
fi

if [ $commands[nvim] ]; then
  alias v='nvim'
  alias vim='nvim'
fi

alias lg='lazygit'
