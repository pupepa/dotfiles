export PATH=$HOME/.vim/plugged/fzf/bin:$PATH
export PATH=$XDG_CONFIG_HOME/nvim/plugged/fzf/bin:$PATH

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!.build/*" --glob "!node_modules/*"'
export FZF_FIND_FILE_OPTS='--preview "bat --color=always --style=header,grid --line-range :100 {}"'
export FZF_LEGACY_KEYBINDINGS=0
export FZF_DEFAULT_OPTS='--reverse --height=100%'
export FZF_REVERSE_ISEARCH_OPTS='--reverse --height=100%'
export FZF_COMPLETE=2
export GHQ_SELECTOR_OPTS='--no-sort --exact --reverse --ansi --color bg+:13,hl:3,pointer:7'
export FZF_FIND_FILE_COMMAND=${FZF_DEFAULT_COMMAND}
export FZF_TMUX_OPTS='-p'

# Functions

# history
function fzf-select-history() {
  local selected_history
  selected_history=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ") || return
  [[ -n $selected_history ]] || return

  BUFFER=$selected_history
  CURSOR=${#BUFFER}
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# ghq
function fzf-select-ghq() {
  local selected_dir repository_dir
  selected_dir=$(ghq list | fzf --query "$LBUFFER" --prompt="Repository > ") || return

  if [[ -n $selected_dir ]]; then
    repository_dir="$(ghq root)/$selected_dir"
    BUFFER="cd ${(q)repository_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-select-ghq
bindkey '^]' fzf-select-ghq

# cdr
function fzf-cdr() {
  local selected_dir
  selected_dir=$(cdr -l | perl -pne 's@^[0-9]+ +@@' | awk '!x[$0]++{print $0}' | fzf) || return

  if [[ -n $selected_dir ]]; then
    BUFFER="cd ${(q)selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-cdr
bindkey '^f' fzf-cdr

function __fzf() {
  local selected_file
  selected_file=$(rg --files --hidden --follow --glob "!.git/*" | fzf) || return
  [[ -n $selected_file ]] || return

  BUFFER=${(q)selected_file}
  CURSOR=${#BUFFER}
}
zle -N __fzf
bindkey '^p' __fzf

function ghi() {
  local selected_pr_id=$(gh issue list --state=all | fzf | awk '{ print $1 }')
  if [ -n "${selected_pr_id}" ]; then
    gh issue view ${selected_pr_id} -p
  fi
}

function ghpr() {
  local selected_pr_id=$(gh pr list | fzf | awk '{ print $1 }')
  if [ -n "${selected_pr_id}" ]; then
    gh pr checkout ${selected_pr_id}
  fi
}

function cdd() {
  local selected_dir
  selected_dir=$(find . -type d | fzf) || return

  if [[ -n $selected_dir ]]; then
    builtin cd -- "$selected_dir"
  fi
}

function gco() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  local branch=$(git for-each-ref --sort=-creatordate --format='%(refname:short)' refs/heads/ |
    fzf --prompt="Branch > " --no-multi --preview-window=right:65% \
      --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" {}')
  if [ -n "${branch}" ]; then
    git checkout "${branch}"
  fi
}

function ql() {
  fzf | xargs -I {} qlmanage -p {} > /dev/null 2&>1
}
