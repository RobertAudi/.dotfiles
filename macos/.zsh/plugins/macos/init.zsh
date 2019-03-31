fpath=("$ZSH_HOME/plugins/macos/functions" $fpath)
function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/macos/functions/*~(*~|*.zwc)(-N.:t)
}

source "$ZSH_HOME/plugins/macos/aliases.zsh"
