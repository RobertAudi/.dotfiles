# cd / smart_cd {{{
# ------------------------------------------------------------------------------
# Source: http://zshwiki.org/home/examples/functions
#
# - cd /etc/fstab → cd /etc
# - corrections on the given dirname (if directory could not be found)
# - all(?) other possible invocations of the builtin 'cd'
# ------------------------------------------------------------------------------

smart_cd() {
  if (($# != 1)); then
    builtin cd "$@"
    return $?
  fi

  if [[ -f "$1" ]]; then
    if [[ -e "${1:h}" ]]; then
      builtin print -P -- "%F{032}INFO%f -- Correcting $1 to ${1:h}"
    fi
    builtin cd "${1:h}"
  else
    builtin cd "$1"
  fi
}

cd() {
  emulate -L zsh
  setopt localoptions
  setopt extendedglob

  local approx1 ; approx1=()
  local approx2 ; approx2=()
  if (( ${#*} == 0 )) || [[ ${1} = [+-]* ]] ; then
    builtin cd "$@"
  elif (( ${#*} == 1 )) ; then
    approx1=( (#a1)${1}(N) )
    approx2=( (#a2)${1}(N) )
    if [[ -e ${1} ]] ; then
      smart_cd ${1}
    elif [[ ${#approx1} -eq 1 ]] ; then
      builtin print -P -- "%F{032}INFO%f -- Correcting $1 to ${approx1[1]}"
      smart_cd ${approx1[1]}
    elif [[ ${#approx2} -eq 1 ]] ; then
      builtin print -P -- "%F{032}INFO%f -- Correcting $1 to ${approx2[1]}"
      smart_cd ${approx2[1]}
    else
      builtin print -P -- "%F{196}ERROR%f -- couldn't correct $1" >&2
      return 1
    fi
  elif (( ${#*} == 2 )) ; then
    builtin cd $1 $2
  else
    builtin print -P -- "%F{196}ERROR%f -- cd: too many arguments" >&2
    return 1
  fi
}

# ------------------------------------------------------------------------------ }}}

# Taken from https://github.com/aspiers/shell-env - .zsh/functions/wh
#   https://github.com/aspiers/shell-env/blob/0f7d4bf/.zsh/functions/wh
where() {
  for thing in "$@"; do
    if [[ `builtin where "$thing"` == *'builtin autoload'* ]]; then
      autoload +X "$thing"
      echo "# Note: $thing was autoloaded"
    fi
  done

  builtin where "$@"
}

# sudo {{{
# ------------------------------------------------------------------------------
# Enable aliases to be sudo’ed
# Works with command/nocorrect/noglob
# Doesn't work with builtins
#
# Source: http://www.zsh.org/mla/users/2008/msg01229.html

alias sudo="noglob do_sudo "

do_sudo() {
  integer glob=1
  local -a run
  run=( command sudo )
  if [[ $# -gt 1 && $1 = -u ]]; then
    run+=($1 $2)
    shift ; shift
  fi
  (($# == 0)) && 1=/bin/zsh
  while (($#)); do
    case "$1" in
      command|exec|-) shift; break ;;
      nocorrect) shift ;;
      noglob) glob=0; shift ;;
      *) break ;;
    esac
  done
  if ((glob)); then
    PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH" $run $~==*
  else
    PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH" $run $==*
  fi
}

# ------------------------------------------------------------------------------ }}}

# Better tree command
tree() {
  # Options:
  #   -C             Colors
  #   -A             ANSI line graphics
  #   -F             Classify (directory: /, executable file: *, etc.)
  #   -a             All files (including hidden files, but not '.' and '..')
  #   -I pattern     Don't list files matching the pattern
  #   --dirsfirst    List directories before files
  #   -L level       Max depth
  local treeopts="-CAFa -I 'rhel.*.*.package|.git|.gem' --dirsfirst"
  if [[ "$1" =~ "^[1-9][0-9]*$" ]]; then
    treeopts="$treeopts -L $1"
    shift
  fi

  command tree $=treeopts "$@"
}

# Disable globbing.
alias fc="noglob fc"
alias find="noglob find"
alias history="noglob history"
alias locate="noglob locate"

# not aliasing rm -i, but if safe-rm is available, use condom.
if ((${+commands[safe-rm]})); then
  alias rm="safe-rm -v"
else
  alias rm="rm -v"
fi

# Be verbose
alias cp="cp -v"
alias chgrp='chgrp --preserve-root -v'
alias chmod="chmod --preserve-root -v"
alias chown="chown --preserve-root -v"
alias mkdir="mkdir -vp"
alias mv="mv -v"
alias ln="ln -v"

# used when you press M-? on a command line
alias which-command='builtin whence -sva'

# List everything
alias type='type -a'

alias grep="grep --binary-files=without-match --exclude=.git{,ignore,modules} --exclude-dir=.{cvs,git,hg,svn} --color=auto"
alias gzip="gzip --verbose --best --name"

alias pgrep="pgrep -il"
alias pkill="pkill -i"

# Replace problematic characters in filenames
alias detox="detox -v"

# Better jobs
alias jobs="jobs -lpd"

# Print directory stack with numbers and one directory per line.
alias dirs="dirs -v -p"

# fancy top
alias top="top -ocpu -R -F -s 2 -n30"

# Use $EDITOR for vidir
alias vidir="VISUAL=\$EDITOR vidir"

alias fetchmail="fetchmail --check"

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
