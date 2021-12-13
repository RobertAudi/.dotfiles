export TSM_HOME="$XDG_DATA_HOME/tsm"
export TSM_SESSIONS_DIR="$TSM_HOME/sessions"
export TSM_BACKUPS_DIR="$TSM_HOME/backups"
export TSM_BACKUPS_COUNT=10

fpath=("$ZSH_HOME/plugins/tmux/functions" $fpath)

function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/tmux/functions/*~(*~|*.zwc)(-N.:t)
}

# is-tmux-runnning returns true if tmux is running
is-tmux-runnning() { [[ -n $TMUX ]] }

if is-tmux-runnning; then
  alias vs="tmux split-window -h"
  alias ss="tmux split-window"
  alias cs="tmux new-window"
  alias fls="tmux list-sessions -F \"#{session_name}\""
fi

typeset -g __gd_without_tpane__
if (( $+aliases[gd] )); then
  __gd_without_tpane__="${aliases[gd]##git }"
  unalias gd
else
  __gd_without_tpane__="diff"
fi
readonly -g __gd_without_tpane__

typeset -g __gl_without_tpane__
if (( $+aliases[gl] )); then
  __gl_without_tpane__="${aliases[gl]##git }"
  unalias gl
else
  __gl_without_tpane__="log"
fi
readonly -g __gl_without_tpane__

gd() { tpane-git diff $@ }
gl() { tpane-git log $@ }

compdef -a _git \
  gd=git-diff   \
  gl=git-log
