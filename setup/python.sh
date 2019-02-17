#!/usr/bin/env zsh

sh "${${(%):-%x}:A:h}/brew.sh"

brew install openssl readline sqlite xz zlib

if [[ -e /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg ]]; then
  sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
fi

brew bundle install --file="${${(%):-%x}:A:h}/Homebrew/python.brewfile"

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

local v
for v in $(print -- "$PYTHON_VERSION" | tr '[:space:]' ' '); do
  env CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix readline)/include" \
    LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib" \
    pyenv install --skip-existing "$v"
done
