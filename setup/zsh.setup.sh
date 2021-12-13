#!/usr/bin/env zsh

command mkdir -p -m 700 -v \
  $HOME/{.config/,.local/{bin,lib,share,zsh}} \
  $HOME/Library/Caches/org.freedesktop/zsh \
  $HOME/.zsh \
  $TMPDIR/zsh

ln -sfv $HOME/Library/Caches/org.freedesktop $HOME/.cache

if type zinit > /dev/null; then
  builtin print -P -- "%F{032}==>%f zinit self-update"
  zinit self-update > /dev/null

  builtin print -P -- "%F{032}==>%f zinit update --all"
  zinit update --all --quiet > /dev/null

  builtin print -P -- "%F{032}==>%f zinit compile --all"
  zinit compile --all > /dev/null
fi
