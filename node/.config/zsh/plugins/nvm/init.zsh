# npm global configuration file
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export NVM_DIR="${HOME}/.local/opt/nvm"

[[ -d "$NVM_DIR" ]] || command mkdir -p "$NVM_DIR"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
