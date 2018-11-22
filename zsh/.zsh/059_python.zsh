is-callable pyenv || return 0
is-callable pyenv-virtualenv-init || return 0

: ${PYENV_ROOT:=$HOME/.pyenv}
export PYENV_ROOT

if [[ -f "$HOME/.python-version" ]]; then
  export PYTHON_VERSION="$(cat $HOME/.python-version)"
fi

{
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
} &!
