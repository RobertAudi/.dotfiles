# Simple bookmarking plugin
#   https://github.com/RobertAudi/zshmarks

: ${BOOKMARKS_FILE:=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}/.bookmarks}
export BOOKMARKS_FILE
[[ -f "$BOOKMARKS_FILE" ]] || touch "$BOOKMARKS_FILE"

alias mark=bookmark

marks() {
  local marks=$(showmarks | awk '{print $1 " - " $2}' | column -t)
  (( $# > 0 )) && marks=$(echo "$marks" | grep "$@")
  echo $marks
}

j() {
  local marks=$(showmarks)
  if (( $#marks == 0 )); then
    echo "No bookmarks found"
    return 1
  fi

  local filter
  zle && filter="$LBUFFER" || filter="$@"

  local fzfopts
  if [[ -n "$filter" ]]; then
    marks=$(echo "$marks" | grep "$filter")
  else
    fzfopts="+1"
  fi

  local mark=$(echo "$marks" | awk '{print $1 " - " $2}' | column -t | fzf-tmux $=fzfopts | awk '{print $1}')
  if [[ -n "$mark" ]]; then
    jump "$mark"
    LBUFFER=
  fi

  zle && zle reset-prompt
}

delete-mark() {
  local marks=$(showmarks)
  if (( $#marks == 0 )); then
    echo "No bookmarks found"
    return 1
  fi

  if (( $# > 0 )); then
    marks=$(echo "$marks" | grep "$@")
  fi

  local height=$(( 4 + $(wc -l <<< "$marks") ))
  local message="Selet bookmark to delete"
  local mark=$(echo "$marks" | awk '{print $1 " - " $2}' | column -t | fzf-tmux --tac --header=$message -d $height +1 +m)
  if [[ -n "$mark" ]]; then
    if [[ "$PWD" == "$(echo "$mark" | awk '{print $3}' | xargs realpath)" ]]; then
      builtin cd
    fi

    deletemark "$(echo "$mark" | awk '{print $1}')"
    command clear; cd .
  fi
}

zle -N z
bindkey "$key_info[Control]G" z
