help() {
  autoload +X run-help

  if (( $# == 0 )); then
    run-help
  elif is-function "run-help-$1"; then
    local cmd="run-help-$1"
    shift
    $cmd $@
  else
    run-help ${=@}
  fi
}

