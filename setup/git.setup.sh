#!/usr/bin/env zsh

emulate -L zsh

setopt pipe_fail

if ! type gh &>/dev/null ; then
  builtin print -P -- "[%F{032}INFO%f] gh not installed."
  builtin print -P -- "[%F{032}INFO%f] Trying to install gh..."

  command brew install gh || return $status

  builtin print -P -- "[%F{032}INFO%f] gh auth status..."

  command gh auth status || return $status
fi

gh extension install dlvhdr/gh-dash
