command_not_found_handler() {
  print -- "୧( ಠ Д ಠ )୨ command not found: $@" >&2
  return 127
}

_chpwd-show-pwd-info() {
  print -P -- "%F{245}In: %F{yellow}%~%f"
}

_chpwd-show-pwd-contents() {
  ls-overview
}

_chpwd-vcs-status-overview() {
  vcs-status-overview
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _chpwd-show-pwd-info
add-zsh-hook chpwd _chpwd-show-pwd-contents
add-zsh-hook chpwd _chpwd-vcs-status-overview
