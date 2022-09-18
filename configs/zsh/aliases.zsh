alias ll='ls -lG'
alias la='ls -laG'

alias rm='trash' # osx-trash
alias cp='cp -i' # -i は確認
alias mv='mv -i' # -i は確認
alias mkdir='mkdir -p' # -p はサブディレクトリごと作成

alias ..='cd ../'
alias ...='cd ../..'
alias ....='cd ../../..'

alias be='bundle exec'

alias tree='pwd;find . | sort | sed "1d;s,[^/]*/,|    ,g;s/..//;s/[^ ]*$/|-- &/"'

alias c=clear

mktdir() {
  mkdir $HOME/tmp/$(date "+%y%m%d") ; cd $_
}

cdt() {
  if [ -d $HOME/tmp/$(date "+%y%m%d") ]; then
    mkdir $HOME/tmp/$(date "+%y%m%d")
  fi
  cd $HOME/tmp/$(date "+%y%m%d")
}

alias r='bin/rails'

alias dk='docker'
alias dkc='docker compose'
alias dks='docker-sync'

alias g='git'

alias ssh='SHELL=/bin/bash ssh'

alias sudo='sudo -E '

case ${OSTYPE} in
  darwin*)
    alias o='open'
    ;;
esac

if [ -n "$TMUX_PANE" ]; then
  alias fzf='fzf-tmux -p 75%,75%'
fi

if [ $commands[nvim] ]; then
  alias vim='nvim'
fi
