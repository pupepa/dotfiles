#!/usr/bin/env bash

set -x

source "$(dirname "$0")/common.bash"

TPM_INSTALL_DIR="$HOME/.tmux/plugins/tmp"

if [ ! -d "$TPM_INSTALL_DIR" ]; then
  mkdir -p "$TPM_INSTALL_DIR"
  git clone https://github.com/tmux-plugins/tpm "$TPM_INSTALL_DIR"
fi
