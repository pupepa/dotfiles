
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Customize to your needs...

source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/bundler.zsh
source $ZDOTDIR/cdr.zsh
source $ZDOTDIR/environments.zsh
source $ZDOTDIR/fzf.zsh
source $ZDOTDIR/git.zsh
source $ZDOTDIR/go.zsh
source $ZDOTDIR/cargo.zsh
source $ZDOTDIR/zinit.zsh

source $ZDOTDIR/asdf.zsh

emulate zsh -c "$(direnv export zsh)"

# if (which zprof > /dev/null) ;then
#   zprof
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Hook direnv into your shell.
eval "$(asdf exec direnv hook zsh)"

# A shortcut for asdf managed direnv.
direnv() { asdf exec direnv "$@"; }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZDOTDIR/p10k.zsh ]] || source $ZDOTDIR/p10k.zsh

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
