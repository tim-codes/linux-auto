#!/usr/bin/env bash

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source -
fisher install jorgebucaran/fisher

if [[ ! -d /Users/tim/.local/share/omf ]]; then
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi
