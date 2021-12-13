#!/usr/bin/env zsh

function main {
  local script_file
  script_file="${DOTFILES_DIR:-${HOME}/.dotfiles}/setup/firefox.rb"

  if [[ -x "$script_file" ]]; then
    $=script_file "$@"
  else
    # print error
    return 1
  fi
}

main "$@"
