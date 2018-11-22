#!/usr/bin/env zsh

type base16-manager >/dev/null || {
  builtin print -P -- "[%F{196}ERROR%f] base16-manager not installed" >&2
  builtin print -P -- "See https://github.com/AuditeMarlow/base16-manager" >&2
  return 1
}

export BASE16_MANAGER_HOME="$HOME/.base16-manager"

if ! base16-manager list | grep --quiet 'chriskempson/base16-shell'; then
  base16-manager install chriskempson/base16-shell
fi

base16-manager update
