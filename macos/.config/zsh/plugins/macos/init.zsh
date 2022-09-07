# iCloud Drive
if [[ -d "$HOME/Library/Mobile Documents/com~apple~CloudDocs" ]]; then
  export ICLOUD_DRIVE_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
  hash -d icloud="$ICLOUD_DRIVE_DIR"
fi

path=(
  /Applications/Postgres.app/Contents/Versions/latest/bin(N-/)
  /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin(N-/)
  /usr/local/MacGPG2/bin(N-/)
  /Library/TeX/Distributions/Programs/texbin(N-/)
  $path
)

manpath=(
  /Applications/Xcode.app/Contents/Developer/usr/share/man(N-/)
  /Applications/Postgres.app/Contents/Versions/latest/share/man(N-/)
  /usr/local/MacGPG2/share/man(N-/)
  /Library/TeX/Distributions/Programs/texbin/man(N-/)
  $manpath
)

fpath=(
  "$ZSH_HOME/plugins/macos/completions"
  "$ZSH_HOME/plugins/macos/functions"
  $fpath
)

function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/macos/{completions,functions}/*~(*~|*.zwc)(-N.:t)
}

source "$ZSH_HOME/plugins/macos/aliases.zsh"
