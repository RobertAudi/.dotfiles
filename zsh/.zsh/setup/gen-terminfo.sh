#!/usr/bin/env bash

# Stolen from https://github.com/tweekmonster/dootfiles
#   https://github.com/tweekmonster/dootfiles/blob/398b9cab745a33d603af7bfbc5e70911e4fa78fc/scripts/gen-terminfo.sh

# Generate xterm-256color and screen-256color terminfo files that supports
# italicized text and standout display style.  This will override the system's
# descriptions of xterm-256color and screen-256color for your shell.
#
# To enable in tmux:
#    set -g default-terminal "xterm-256color"
#
# tmux recommends creating an `tmux-256color` terminfo file and setting the
# default-terminal to "xterm", but this causes ssh sessions to not display
# correctly unless it has the correct terminfo, among other goofy behavior from
# shells that don't know what to do with TERM=tmux
#
# The drawback with tmux using "xterm-256color" is that some programs may not
# display colors correctly.  This can be resolved by adding aliases for those
# programs:
#    alias htop='TERM=screen-256color htop'

generate() {
  echo "Generating $1"
  tmpfile=$(mktemp /tmp/terminfo.XXXXXXX)
  /usr/bin/infocmp "$1" | sed -e 's/\(ritm\|sitm\|rmso\|smso\)=[^,]\+, *//g' > $tmpfile
  echo '	sitm=\E[3m, ritm=\E[23m,' >> $tmpfile
  echo '	smso=\E[7m, rmso=\E[27m,' >> $tmpfile
  echo '	Ms@,' >> $tmpfile
  /usr/bin/tic -x $tmpfile
  rm -f $tmpfile
}

generate 'xterm-256color'
generate 'screen-256color'
