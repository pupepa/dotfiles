#!/usr/bin/env bash

set -eux

if [ ! -d "$HOME/.ssh" ]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
fi

mkdir -p \
  "$XDG_CONFIG_HOME" \
  "$XDG_STATE_HOME" \
  "$XDG_DATA_HOME" \
  "$XDG_CACHE_HOME/zsh" \
  "$XDG_DATA_HOME/zsh"

/bin/bash "$CURRENT_DIR/setup_zinit.bash"
/bin/bash "$CURRENT_DIR/setup_textlint_and_rules.sh"
