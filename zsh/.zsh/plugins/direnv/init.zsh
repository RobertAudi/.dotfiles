if is-command direnv; then
  cache_file="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}/direnv-cache.$UID.zsh"

  if [[ "$commands[direnv]" -nt "$cache_file" || ! -s "$cache_file" ]]; then
    direnv hook zsh >! "$cache_file" 2> /dev/null
    zcompile -U "$cache_file"
  fi

  source "$cache_file"
  unset cache_file
fi
