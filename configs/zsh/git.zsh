typeset git_prefix
if (( $+commands[brew] )) && git_prefix=$(brew --prefix git 2>/dev/null) &&
  [[ -d $git_prefix/share/git-core/contrib/diff-highlight ]]; then
  export PATH="$git_prefix/share/git-core/contrib/diff-highlight:$PATH"
fi
unset git_prefix

# git-wt
if (( $+commands[git-wt] )); then
  eval "$(git wt --init zsh)"
fi

wcd() {
  local selected_dir
  selected_dir=$(git-wt | fzf --header-lines=1 | awk '{if ($1 == "*") print $2; else print $1}')
  [[ -n $selected_dir ]] || return

  builtin cd -- "$selected_dir"
}

