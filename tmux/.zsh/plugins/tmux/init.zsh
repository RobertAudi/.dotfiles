fpath=("$ZSH_HOME/plugins/tmux/functions" $fpath)
function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/tmux/functions/*~(*~|*.zwc)(-N.:t)
}

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
