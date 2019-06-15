# tj/n
export N_PREFIX="$HOME/.n"

# molovo/tipz
export TIPZ_TEXT=" 💡  Alias tip:"

# zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=cyan,fg=bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

if is-widget history-substring-search-up; then
  bindkey "$key_info[Up]" history-substring-search-up
  bindkey "$key_info[Control]P" history-substring-search-up
fi

if is-widget history-substring-search-down; then
  bindkey "$key_info[Down]" history-substring-search-down
  bindkey "$key_info[Control]N" history-substring-search-down
fi

# jimeh/tmuxifier
if is-callable tmuxifier; then
  export TMUXIFIER_LAYOUT_PATH="$XDG_CONFIG_HOME/tmuxifier/layouts"
  eval "$(tmuxifier init -)"
  alias mux="tmuxifier"
fi

if is-command direnv; then
  cache_file="${TMPDIR:-/tmp}/direnv-cache.$UID.zsh"

  if [[ "$commands[direnv]" -nt "$cache_file" || ! -s "$cache_file" ]]; then
    direnv hook zsh >! "$cache_file" 2> /dev/null
  fi

  source "$cache_file"
  unset cache_file
fi
