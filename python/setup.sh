#!/usr/bin/env zsh

function {
  local brewfile="${${(%):-%x}:h:A}/Brewfile"
  if [[ -f "$brewfile" ]]; then
    brew bundle install --file="$brewfile"
  fi

  path=($HOME/.pyenv/bin(N-/) $path)
  typeset -gU path
  export PATH

  if ! type pyenv &>/dev/null; then
    builtin print -- "[$(tput setaf 1)ERROR$(tput sgr0)] pyenv not found" >&2
    return 1
  fi

  : ${PYENV_ROOT:=$HOME/.pyenv}
  export PYENV_ROOT

  if [[ -f "$HOME/.python-version" ]]; then
    export PYTHON_VERSION="$(cat $HOME/.python-version)"
  else
    export PYTHON_VERSION="3.6.5 2.7.14"
  fi

  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

  for v in "${(@s/ /)PYTHON_VERSION}"; do
    CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix readline)/include" \
      LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib" \
      pyenv install "$v"
  done
}
