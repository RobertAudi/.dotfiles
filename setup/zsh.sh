#!/usr/bin/env zsh

if type zplugin > /dev/null; then
  builtin print -P -- "%F{032}==>%f zplugin self-update"
  zplugin self-update > /dev/null

  builtin print -P -- "%F{032}==>%f zplugin update --all"
  zplugin update --all --quiet > /dev/null

  builtin print -P -- "%F{032}==>%f zplugin compile --all"
  zplugin compile --all > /dev/null
fi
