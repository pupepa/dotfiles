#!/bin/sh

MARTA_CONFIG_PATH="$HOME/Library/Application Support/org.yanex.marta"

if [ -d "${MARTA_CONFIG_PATH}" ]; then
  rm -ri "${MARTA_CONFIG_PATH}"
fi

ln -s ./org.yanex.marta "${MARTA_CONFIG_PATH}"
