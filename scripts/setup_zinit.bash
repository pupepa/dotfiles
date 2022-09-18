#!/usr/bin/env bash

source "$(dirname "$0")/common.bash"

if [ ! -d "$XDG_DATA_HOME/zinit/bin" ]; then
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi
