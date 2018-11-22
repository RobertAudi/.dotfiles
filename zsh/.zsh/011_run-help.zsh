# A smarter help widget, this will look for
# a file before resorting to using man.
unalias run-help 2> /dev/null

# Helper functions.
# Authoload them BEFORE autoloading run-help
autoload -Uz run-help-git
autoload -Uz run-help-openssl
autoload -Uz run-help-sudo
autoload -Uz run-help
autoload +X run-help

function help() {
  if (( $# == 0 )); then
    run-help
  elif is-function "run-help-$1"; then
    local cmd="run-help-$1"
    shift
    $cmd $@
  else
    run-help $@
  fi
}
