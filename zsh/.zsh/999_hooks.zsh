command_not_found_handler() {
  print -- "୧( ಠ Д ಠ )୨ command not found: $1" >&2
  return 127
}

_chpwd-show-pwd-info() {
  print -P -- "%F{245}In: %F{yellow}%~%f"
}

_chpwd-show-pwd-contents() {
  ls -A --color=always
}

_chpwd-git-status-overview() {
  if is-callable git-status-overview; then
    git-status-overview
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _chpwd-show-pwd-info
add-zsh-hook chpwd _chpwd-show-pwd-contents
add-zsh-hook chpwd _chpwd-git-status-overview
