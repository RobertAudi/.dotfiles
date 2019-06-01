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

if [[ -d "$HOME/.cargo/bin" ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
