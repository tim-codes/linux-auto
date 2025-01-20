#!/bin/zsh

cp -i ~/dev/linux-auto/fish/common.fish ~/dev/linux-auto/fish/linux.fish ~/.config/fish/
echo '
# ~~~~ WARNING: DO NOT EDIT THIS FILE ~~~~ #
set -x fish_conf "$HOME/.config/fish/config.fish"
source ~/.config/fish/mac.fish
' > ~/.config/fish/config.fish
source ~/.config/fish/config.fish