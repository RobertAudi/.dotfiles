export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="$XDG_CACHE_HOME"

export IRBRC="$XDG_CONFIG_HOME/irb/irbrc"
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgreprc"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

if command -v nvim >/dev/null; then
  export VIM_COMMAND="nvim"
else
  export VIM_COMMAND="vim"
fi

if command -v vimr >/dev/null; then
  export GVIM_COMMAND="vimr"
  export GVIEW_COMMAND="$=GVIM_COMMAND --nvim -R"
fi

if [[ -d "/usr/local/MacGPG2/bin" ]]; then
  export PATH="/usr/local/MacGPG2/bin:$PATH"
fi

if [[ -d "$HOME/.cargo/bin" ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
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
