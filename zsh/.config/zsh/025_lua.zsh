if [[ -v LUA_LSP_HOME && -f "${LUA_LSP_HOME}/3rd/luamake/luamake" ]] && ! type luamake > /dev/null ; then
  alias luamake="${LUA_LSP_HOME}/3rd/luamake/luamake"
fi

# Lua version manager
: ${LUVER_DIR:=${HOME}/.local/opt/luver}

if [[ -d "${LUVER_DIR}/self" ]]; then
  export LUVER_DIR

  source "${LUVER_DIR}/self/luver.plugin.zsh"
fi
