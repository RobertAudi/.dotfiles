# iCloud Drive
if [[ -d "$HOME/Library/Mobile Documents/com~apple~CloudDocs" ]]; then
  export ICLOUD_DRIVE_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
  hash -d icloud="$ICLOUD_DRIVE_DIR"
fi

path=(/usr/local/MacGPG2/bin(N-/) $path)
fpath=("$ZSH_HOME/plugins/macos/completions" "$ZSH_HOME/plugins/macos/functions" $fpath)
function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/macos/{completions,functions}/*~(*~|*.zwc)(-N.:t)
}

source "$ZSH_HOME/plugins/macos/aliases.zsh"
