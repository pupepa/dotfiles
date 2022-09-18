#!/usr/bin/env bash

set -x

source "$(dirname "$0")/common.bash"

if [ $(uname) != "Darwin" || $SKIP_HOMEBREW ]; then
  exit
fi

if type -P brew >/dev/null; then
  brew update
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle install --file "${DOTFILES_DIR}/config/homebrew/Brewfile.common" --no-lock --verbose
if [ $HOMEBREW_WORK ]; then
  brew bundle install --file "${DOTFILES_DIR}/config/homebrew/Brewfile.work" --no-lock --verbose
else
  brew bundle install --file "${DOTFILES_DIR}/config/homebrew/Brewfile.home" --no-lock --verbose
fi
