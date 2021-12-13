#!/usr/bin/env zsh

# Repo: https://github.com/sumneko/lua-language-server
function install-lua-language-server {
  emulate -L zsh

  setopt pipe_fail

  if ! (( $+commands[ninja] )) &>/dev/null; then
    command brew install ninja
  fi

  : ${LUA_LSP_HOME:=${HOME}/.local/opt/lua-language-server}
  export LUA_LSP_HOME

  if [[ ! -d $LUA_LSP_HOME ]]; then
    command git clone https://github.com/sumneko/lua-language-server $LUA_LSP_HOME
  fi

  builtin cd -q $LUA_LSP_HOME

  command git submodule update --init --recursive

  builtin cd -q 3rd/luamake

  ninja -f compile/ninja/macos.ninja

  unalias luamake &> /dev/null
  alias luamake="${LUA_LSP_HOME}/3rd/luamake/luamake"

  builtin cd -q ../..

  ./3rd/luamake/luamake rebuild
}

function main {
  emulate -L zsh

  setopt pipe_fail

  install-lua-language-server
}

main
