fpath=("$ZSH_HOME/plugins/archive/functions" $fpath)
autoload -Uz $ZSH_HOME/plugins/archive/functions/*~(*~|*.zwc)(-N.:t)

if type atool >/dev/null; then
  alias xx="atool -x"
fi
