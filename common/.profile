export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

if [[ -d "$HOME/.cargo/bin" ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
