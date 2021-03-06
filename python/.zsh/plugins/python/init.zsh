is-callable pyenv || return 0
is-callable pyenv-virtualenv-init || return 0

: ${PYENV_ROOT:=$HOME/.pyenv}
export PYENV_ROOT

if [[ -f "$HOME/.python-version" ]]; then
  export PYTHON_VERSION="$(cat $HOME/.python-version)"
fi

pyenv_cache_file="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}/pyenv-cache.$UID.zsh"
pyenv_virtualenv_cache_file="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}/pyenv-virtualenv-cache.$UID.zsh"

if [[ "$commands[pyenv]" -nt "$pyenv_cache_file" || ! -s "$pyenv_cache_file" ]]; then
  pyenv init - >! "$pyenv_cache_file" 2> /dev/null
  pyenv virtualenv-init - >! "$pyenv_virtualenv_cache_file" 2> /dev/null
  zcompile -U "$pyenv_cache_file"
  zcompile -U "$pyenv_virtualenv_cache_file"
fi

source "$pyenv_cache_file"
source "$pyenv_virtualenv_cache_file"
unset pyenv_cache_file pyenv_virtualenv_cache_file
