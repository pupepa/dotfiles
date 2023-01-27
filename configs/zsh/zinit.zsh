source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
zinit ice wait'!0'; zinit load zsh-users/zsh-completions
zinit ice wait'!0'; zinit load zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light olets/zsh-abbr

setopt promptsubst

fpath=($HOME/.zinit/plugins/zsh-users---zsh-completions $fpath)
