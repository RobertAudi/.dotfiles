# ZSH port of Fish history search
#   https://github.com/zsh-users/zsh-history-substring-search

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
