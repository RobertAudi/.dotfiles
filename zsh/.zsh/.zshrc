[ -n "$PROFILE_INIT" ] && zmodload zsh/zprof

#   umask   directory   file
#   002     775         664
#   022     755         644
umask 022
limit coredumpsize 0

# Disable C-s and C-q for job control
stty -ixon -ixoff
stty start undef
stty stop undef

export SSH_PUBLIC_KEY=$(<$HOME/.ssh/id_rsa.pub)

if brew command command-not-found-init > /dev/null; then
  { eval "$(brew command-not-found-init)" } &!
fi

# LDFLAGS / CPPFLAGS / PKG_CONFIG_PATH
# ------------------------------------------------------------------------------ {{{

# Tie PKG_CONFIG_PATH and pkg_config_path together
typeset -T PKG_CONFIG_PATH pkg_config_path

# Flex
# ------------------------------------------------------------------------------
if [[ -d "/usr/local/opt/flex/lib" ]]; then
  export LDFLAGS="$LDFLAGS -L/usr/local/opt/flex/lib"
fi

if [[ -d "/usr/local/opt/flex/include" ]]; then
  export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/flex/include"
fi

# Bison
# ------------------------------------------------------------------------------
if [[ -d "/usr/local/opt/bison/lib" ]]; then
  export LDFLAGS="$LDFLAGS -L/usr/local/opt/bison/lib"
fi

# LibreSSL / OpenSSL
# ------------------------------------------------------------------------------
if [[ -d "/usr/local/opt/libressl" ]]; then
  if [[ -d "/usr/local/opt/libressl/lib" ]]; then
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/libressl/lib"
  fi

  if [[ -d "/usr/local/opt/libressl/include" ]]; then
    export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/libressl/include"
  fi

  if [[ -d "/usr/local/opt/libressl/lib/pkgconfig" ]]; then
    pkg_config_path=(/usr/local/opt/libressl/lib/pkgconfig(N-/) ${(@)pkg_config_path:#/usr/local/opt/openssl/lib/pkgconfig})
  fi
elif [[ -d "/usr/local/opt/openssl" ]]; then
  if [[ -d "/usr/local/opt/openssl/lib" ]]; then
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/openssl/lib"
  fi

  if [[ -d "/usr/local/opt/openssl/include" ]]; then
    export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openssl/include"
  fi

  if [[ -d "/usr/local/opt/openssl/lib/pkgconfig" ]]; then
    pkg_config_path=(/usr/local/opt/openssl/lib/pkgconfig(N-/) ${(@)pkg_config_path:#/usr/local/opt/libressl/lib/pkgconfig})
  fi
fi

# ------------------------------------------------------------------------------ }}}

if [[ ! -v LESSOPEN ]] && [[ -f "/usr/local/bin/lesspipe.sh" ]]; then
  export LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
  export LESS_ADVANCED_PREPROCESSOR=1
fi

if [[ -f "$ZDOTDIR/setup/perl.zsh" ]]; then
  source "$ZDOTDIR/setup/perl.zsh"
fi

# Base16 Shell
export BASE16_MANAGER_HOME="$HOME/.base16-manager"
export BASE16_SHELL="$BASE16_MANAGER_HOME/chriskempson/base16-shell"

if [[ -f "$BASE16_SHELL/scripts/base16-railscasts.sh" ]]; then
  source "$BASE16_SHELL/scripts/base16-railscasts.sh"
fi

# Required because otherwise it goes to shit.....
autoload -Uz zstyle+

if [[ -n "$ZPLG_HOME" && -f "$ZPLG_HOME/bin/zplugin.zsh" ]]; then
  source "$ZPLG_HOME/bin/zplugin.zsh"

  if [[ -n "$ZPLG_LOADFILE" && -f "$ZPLG_LOADFILE" ]]; then
    source "$ZPLG_LOADFILE"
  fi
fi

for f in $ZSH_HOME/*.zsh; do
  source $f
done
unset f

if [[ -f "$ZSH_HOME/.zshrc.private" ]]; then
  source "$ZSH_HOME/.zshrc.private"
fi

if [[ -f "$ZSH_HOME/.zshrc.local" ]]; then
  source "$ZSH_HOME/.zshrc.local"
fi

# Remove duplicate path entries
typeset -gU path
typeset -gU sudo_path
typeset -gU manpath
typeset -gU infopath
typeset -gU fpath
typeset -gU pkg_config_path

export PATH SUDO_PATH MANPATH INFOPATH FPATH PKG_CONFIG_PATH

[ -n "$PROFILE_INIT" ] && zprof
