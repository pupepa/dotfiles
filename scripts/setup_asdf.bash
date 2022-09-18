#!/usr/bin/env bash

set -x

source "$(dirname "$0")/common.bash"

RUBY2_VERSION=2.6.7
RUBY3_VERSION=3.0.4
PYTHON_VERION=3.9.5
NODEJS_VERSION=16.15.1
DIRENV_VERSION=2.28.0
HUB_VERSION=v2.14.2

PLUGINS=(ruby python nodejs direnv hub)

ASDF_INSTALL_DIR="$HOME/.asdf"
if [ ! -d "$ASDF_INSTALL_DIR" ]; then
  git clone https://github.com/asdf-vm/asdf.git "$ASDF_INSTALL_DIR" --branch v0.10.0
fi

source $HOME/.asdf/asdf.sh

for PLUGIN in ${PLUGINS[@]}
do
  asdf plugin add ${PLUGIN}
done

asdf install ruby ${RUBY2_VERSION}
asdf install ruby ${RUBY3_VERSION}
asdf install python ${PYTHON_VERION}
asdf install nodejs ${NODEJS_VERSION}
asdf install direnv ${DIRENV_VERSION}
asdf install hub ${HUB_VERSION}

asdf global ruby ${RUBY2_VERSION}
asdf global python ${PYTHON_VERION}
asdf global nodejs ${NODEJS_VERSION}
asdf global direnv ${DIRENV_VERSION}
asdf global hub ${HUB_VERSION}
