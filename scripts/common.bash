#!/usr/bin/env bash

set -x

export CURRENT_DIR DOTFILES_DIR
CURRENT_DIR="$(cd "$(dirname "$0")" || exit 1; pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/ghq/github.com/dre-jp/dotfiles}"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
