# A smarter help widget, this will look for
# a file before resorting to using man.
(( $+aliases[run-help] )) && unalias run-help

# Helper functions.
# Authoload them BEFORE autoloading run-help
autoload -Uz run-help-git
autoload -Uz run-help-openssl
autoload -Uz run-help-ssh
autoload -Uz run-help-sudo
autoload -Uz run-help

help() {
  autoload +X run-help
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

# Source: https://github.com/grml/grml-etc-core/blob/6e8ffd2ea9534d91df0f86d6b7d9bc972164cd0e/etc/zsh/zshrc#L3186-L3225
# Provides useful information on globbing
function H-Glob () {
    echo -e "
    /      directories
    .      plain files
    @      symbolic links
    =      sockets
    p      named pipes (FIFOs)
    *      executable plain files (0100)
    %      device files (character or block special)
    %b     block special files
    %c     character special files
    r      owner-readable files (0400)
    w      owner-writable files (0200)
    x      owner-executable files (0100)
    A      group-readable files (0040)
    I      group-writable files (0020)
    E      group-executable files (0010)
    R      world-readable files (0004)
    W      world-writable files (0002)
    X      world-executable files (0001)
    s      setuid files (04000)
    S      setgid files (02000)
    t      files with the sticky bit (01000)

  print *(m-1)          # Files modified up to a day ago
  print *(a1)           # Files accessed a day ago
  print *(@)            # Just symlinks
  print *(Lk+50)        # Files bigger than 50 kilobytes
  print *(Lk-50)        # Files smaller than 50 kilobytes
  print **/*.c          # All *.c files recursively starting in \$PWD
  print **/*.c~file.c   # Same as above, but excluding \"file.c\"
  print (foo|bar).*     # Files starting with \"foo\" or \"bar\"
  print *~*.*           # All Files that do not contain a dot
  chmod 644 *(.^x)      # make all plain non-executable files publically readable
  print -l *(.c|.h)     # Lists *.c and *.h
  print **/*(g:users:)  # Recursively match all files that are owned by group \"users\"
  echo /proc/*/cwd(:h:t:s/self//) # Analogous to >ps ax | awk '{print $1}'<"
}
alias help-zshglob=H-Glob
