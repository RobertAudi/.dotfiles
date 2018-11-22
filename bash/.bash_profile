if [[ -d "$HOME/.cargo/bin" ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

if [[ -d "/usr/local/opt/openssl/lib/pkgconfig" ]]; then
  export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
fi

if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
fi

if [[ -f "$HOME/.python-version" ]]; then
  export PYTHON_VERSION="$(cat $HOME/.python-version)"
fi

if type pyenv >/dev/null && type pyenv-virtualenv-init >/dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Case insensitive tab completion in Bash
# http://superuser.com/questions/90196/case-insensitive-tab-completion-in-bash
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
