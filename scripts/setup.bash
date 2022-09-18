#!/usr/bin/env bash

set -eux

source "$(dirname "$0")/common.bash"

if [ ! -d "$HOME/.ssh" ]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
fi

mkdir -p \
  "$XDG_CONFIG_HOME" \
  "$XDG_STATE_HOME" \
  "$XDG_DATA_HOME"

CONFIG_DIRS=(`ls -1 $DOTFILES_DIR/configs`)
for config_dir in ${CONFIG_DIRS[@]}
do
  ln -sfnv "$DOTFILES_DIR/configs/$config_dir" "$XDG_CONFIG_HOME/$config_dir"
done

ln -sfv "$XDG_CONFIG_HOME/default-gems/default-gems" "$HOME/.default-gems"
ln -sfv "$XDG_CONFIG_HOME/ideavim/.ideavimrc" "$HOME/.ideavimrc"
ln -sfv "$XDG_CONFIG_HOME/swift-format/.swift-format" "$HOME/.swift-format"
ln -sfv "$XDG_CONFIG_HOME/textlint/.textlintrc" "$HOME/.textlintrc"
ln -sfv "$XDG_CONFIG_HOME/prh/prh.yml" "$HOME/prh.yml"
ln -sfv "$XDG_CONFIG_HOME/zsh/.zshenv" "$HOME/.zshenv"
ln -sfnv "$XDG_CONFIG_HOME/vim" "$HOME/.vim"
ln -sfnv "$XDG_CONFIG_HOME/w3m" "$HOME/.w3m"

ln -sfv "$XDG_CONFIG_HOME/vim/vimrc" "$XDG_CONFIG_HOME/nvim/init.vim"
ln -sfv "$XDG_CONFIG_HOME/vim/vimrc.plugins" "$XDG_CONFIG_HOME/nvim/vimrc.plugins"
ln -sfnv "$XDG_CONFIG_HOME/vim/after" "$XDG_CONFIG_HOME/nvim/after"
ln -sfnv "$XDG_CONFIG_HOME/vim/plugged" "$XDG_CONFIG_HOME/nvim/plugged"

/bin/bash "$CURRENT_DIR/setup_zinit.bash"
/bin/bash "$CURRENT_DIR/setup_tpm.bash"
/bin/bash "$CURRENT_DIR/setup_asdf.bash"
/bin/bash "$CURRENT_DIR/setup_textlint_and_rules.bash"
