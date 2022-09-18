# zmodload zsh/zprof && zprof

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

export ZSH_COMPDUMP=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share:$HOME/bin:$PATH
