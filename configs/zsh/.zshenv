# zmodload zsh/zprof && zprof

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share:$HOME/bin:$PATH
