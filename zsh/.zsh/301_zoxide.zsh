if (( $+commands[zoxide] )) &>/dev/null; then
  cache_file="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}/zoxide-cache.$UID.zsh"

  if [[ "$commands[zoxide]" -nt "$cache_file" || ! -s "$cache_file" ]]; then
    zoxide init zsh >! "$cache_file" 2> /dev/null
    zcompile -U "$cache_file"
  fi

  source "$cache_file"
  unset cache_file
fi
