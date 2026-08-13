export PATH="$(brew --prefix git)/share/git-core/contrib/diff-highlight:$PATH"

# git-wt
if (( $+commands[git-wt] )); then
  eval "$(git wt --init zsh)"
fi

wcd() {
  cd $(git-wt | fzf --header-lines=1 | awk '{if ($1 == "*") print $2; else print $1}')
}

