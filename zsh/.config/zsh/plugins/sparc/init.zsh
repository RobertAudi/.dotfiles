if [[ ! -x "$HOME/.local/bin/sparc" ]]; then
  gcc "$ZSH_HOME/plugins/sparc/lib/sparc.c" -o "$HOME/.local/bin/sparc"
fi
