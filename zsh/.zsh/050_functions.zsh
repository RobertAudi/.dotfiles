# Autoload shell functions from all directories in $fpath
# expect if they're part of a plugin.
# Let plugins autoload their functions.
typeset dirname
typeset -a fns
for dirname in $fpath; do
  if ! [[ $dirname =~ ($ZDOTDIR/plugins|${ZPLG_HOME:-$HOME/.zplugin})/* ]]; then
    fns=( $dirname/*~(*~|*.zwc)(-N.:t) )
    (( $#fns > 0 )) && autoload -Uz -- "$fns[@]"
  fi
done
unset dirname fns

# Modern Make: https://github.com/tj/mmake
if is-callable mmake; then
  function make() { mmake "$@" }
fi

# Reload functions.
refunc() {
  while (( $# > 0 )); do
    if unfunction $1; then
      autoload -Uz $1
      print-success "Function reloaded: $1"
    fi

    shift
  done
}

# Reload the shell (i.e. invoke as a login shell)
reload-shell() {
  if builtin jobs | grep . &>/dev/null; then
    print-error "Jobs running. Shell reload aborted."
    builtin jobs -lpd >&2
  else
    clear-buffer
    # Remove leading dash if login shell
    exec ${SHELL#-}
  fi
}

which-less() {
  if (( $# > 0 )); then
    less --quit-if-one-screen $(which $1)
  else
    print-error 'Nothing to show...'
  fi
}

cat-dups() { cat $@ | sort | uniq -c | sort -n }

# list images only
limg() {
  local -a images
  images=( *.{jpg,gif,png}(.N) )
  if [[ $#images -eq 0 ]] ; then
    print "No image files found"
  else
    ls "$@" "$images[@]"
  fi
}

ls.() {
  if [[ -d "$1" ]]; then
    builtin cd $1 >/dev/null && shift && ls. $@
    builtin cd -
  else
    ls -d .[^.]* $@
  fi
}

# -------------------------------------------------------------------
# Find files and exec commands at them.
# $ find-exec .coffee cat | wc -l
# # => 9762
# from https://github.com/paulmillr/dotfiles
# -------------------------------------------------------------------
find-exec() {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# $ git log --no-merges --pretty=format:"%ae" | stats
# # => 514 a@example.com
# # => 200 b@example.com
stats() {
  sort | uniq -c | sort -r
}

# Displays user owned processes status.
psu() {
  ps -U "${1:-$LOGNAME}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

# Inline calculator
function = {
  local operation result
  operation="$(builtin print -n -- "$@" | tr 'x' '*')"

  if is-command eva ; then
    result="$(builtin print -n -- "$operation" | eva)"
  else
    result="$(builtin print -n -- "$operation" | bc -l)"
  fi

  builtin printf "%s\n" "${result#"${result%%[![:space:]]*}"}"
}

# Profile a function with zprof.
# Usage: zprof-func some-function with-arguments
zprof-func() {
  (
    unset precmd_functions
    zmodload zsh/zprof
    $@
    zprof
  )
}
