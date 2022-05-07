if [[ -v LUA_LSP_HOME && -f "${LUA_LSP_HOME}/3rd/luamake/luamake" ]] && ! is-callable luamake ; then
  alias luamake="${LUA_LSP_HOME}/3rd/luamake/luamake"
fi
