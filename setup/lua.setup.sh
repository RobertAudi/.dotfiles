#!/usr/bin/env zsh

emulate -L zsh

setopt pipe_fail

brew bundle install --file="${${(%):-%x}:A:h}/Homebrew/lua.brewfile"

luarocks install luacheck

if ! type cargo ; then
  source "${${(%):-%x}:A:h}/rust.setup.sh"

  cargo install-update stylua
fi
