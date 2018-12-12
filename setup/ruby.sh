#!/usr/bin/env zsh

if ! type ruby-install >/dev/null; then
  builtin print -P -- "[%F{196}ERROR%f] Missing requirement: %Bruby-install%b" >&2
  builtin print -P -- "See https://github.com/postmodern/ruby-install#readme" >&2
  return 1
fi

local number_of_cores=$(sysctl -n hw.ncpu)
local src_dir="${XDG_CACHE_HOME:-$HOME/.cache}/rubies"

local ruby_version
if [[ -f "$HOME/.ruby-version" ]]; then
  ruby_version="$(cat "$HOME/.ruby-version")"
else
  ruby_version="ruby"
fi

command ruby-install --latest
command ruby-install \
  --jobs=$number_of_cores \
  --src-dir $src_dir \
  --cleanup \
  --no-reinstall \
  $ruby_version
