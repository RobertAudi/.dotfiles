#!/usr/bin/env zsh

emulate -L zsh

setopt pipe_fail

local -A opts
zparseopts -D -E -A opts -init

if (( ${+opts[--init]} )); then
  brew bundle install --file="${${(%):-%x}:A:h}/Homebrew/lua.brewfile"

  # luver: Version manager for Lua, built with ❤️   {{{
  #   https://github.com/MunifTanjim/luver
  # ------------------------------------------------------------------------
  : ${LUVER_DIR:=${HOME}/.local/opt/luver}
  export LUVER_DIR

  command mkdir -p "${LUVER_DIR}"

  if [[ -d "${LUVER_DIR}/self" ]]; then
    (
      cd -q "${LUVER_DIR}/self"

      if is-git-repo ; then
        git pull
      else
        builtin print -P -u 2 -- "Unable to install luver"
        return 1
      fi
    )
  else
    command git clone https://github.com/MunifTanjim/luver.git "${LUVER_DIR}/self"
  fi

  if [[ -f "${LUVER_DIR}/self/completions/_luver" ]]; then
    command cp -f "${LUVER_DIR}/self/completions/_luver" ${ZSH_HOME:-${ZDOTDIR:-$HOME/.zsh}}/completions/
  fi
  # ------------------------------------------------------------------------ }}}
fi

# A set of pure Lua libraries focusing on input data handling (such as reading configuration files),
# functional programming (such as map, reduce, placeholder expressions,etc), and OS path management.
# Much of the functionality is inspired by the Python standard libraries.
#   https://github.com/lunarmodules/Penlight
#   https://lunarmodules.github.io/Penlight/
luarocks install penlight
luarocks install penlight --lua-version 5.1

# A tool for linting and static analysis of Lua code.
#   https://github.com/lunarmodules/luacheck
#   https://luacheck.readthedocs.io/en/stable/
luarocks install luacheck

if ! type cargo ; then
  source "${${(%):-%x}:A:h}/rust.setup.sh"

  # An opinionated Lua code formatter
  #   https://github.com/JohnnyMorganz/StyLua
  cargo install-update stylua
fi
