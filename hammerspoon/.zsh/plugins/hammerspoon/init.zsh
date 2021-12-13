path=(
  /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/ipc/bin(N-/)
  $path
)

manpath=(
  /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/ipc/share/man(N-/)
  $manpath
)

fpath=(
  "$ZSH_HOME/plugins/Hammerspoon/functions"
  $fpath
)

function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/Hammerspoon/functions/*~(*~|*.zwc)(-N.:t)
}
