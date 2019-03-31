# iCloud Drive
if [[ -d "$HOME/Library/Mobile Documents/com~apple~CloudDocs" ]]; then
  export ICLOUD_DRIVE_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
  hash -d icloud="$ICLOUD_DRIVE_DIR"
fi

fpath=("$ZSH_HOME/plugins/macos/functions" $fpath)
function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/macos/functions/*~(*~|*.zwc)(-N.:t)
}

source "$ZSH_HOME/plugins/macos/aliases.zsh"
