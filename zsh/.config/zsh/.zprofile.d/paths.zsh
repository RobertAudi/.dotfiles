# Reference:
# ----------
# (N-/): do not register if the directory is not exists
#  N: NULL_GLOB option (ignore path if the path does not match the glob)
#  -: follow the symbol links
#  /: ignore files

# PATH
# ------------------------------------------------------------------------------ {{{

path=(
  $XDG_BIN_HOME(N-/)
  $XDG_DATA_HOME/npm/bin(N-/)
  $HOME/.pyenv/bin(N-/)
  $HOME/.n/bin(N-/)
  $HOME/.tmuxifier/bin(N-/)
  $HOME/.cargo/bin(N-/)
  $HOME/perl5/bin(N-/)
  ${GOPATH:+$GOPATH/bin}(N-/)
  /opt/homebrew/opt/curl/bin(N-/)
  /opt/homebrew/opt/openssl/bin(N-/)
  /opt/homebrew/opt/ncurses/bin(N-/)
  /opt/homebrew/opt/sqlite/bin(N-/)
  /opt/homebrew/opt/llvm/bin(N-/)
  /opt/homebrew/opt/ruby/bin(N-/)
  /opt/homebrew/opt/python/libexec/bin(N-/)
  /opt/homebrew/opt/libxml2/bin(N-/)
  /opt/homebrew/opt/libxslt/bin(N-/)
  /opt/homebrew/opt/binutils/bin(N-/)
  /opt/homebrew/opt/coreutils/libexec/gnubin(N-/)
  /opt/homebrew/opt/ed/libexec/gnubin(N-/)
  /opt/homebrew/opt/file-formula/bin(N-/)
  /opt/homebrew/opt/findutils/libexec/gnubin(N-/)
  /opt/homebrew/opt/gettext/bin(N-/)
  /opt/homebrew/opt/gnu-indent/libexec/gnubin(N-/)
  /opt/homebrew/opt/gnu-sed/libexec/gnubin(N-/)
  /opt/homebrew/opt/gnu-tar/libexec/gnubin(N-/)
  /opt/homebrew/opt/grep/libexec/gnubin(N-/)
  /opt/homebrew/opt/m4/bin(N-/)
  /opt/homebrew/opt/make/libexec/gnubin(N-/)
  /opt/homebrew/opt/nss/bin(N-/)
  /opt/homebrew/opt/unzip/bin(N-/)
  /opt/homebrew/opt/ssh-copy-id/bin(N-/)
  /opt/homebrew/bin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
  $path
)

# ------------------------------------------------------------------------------ }}}

# SUDO_PATH
# ------------------------------------------------------------------------------ {{{

# -x: do export SUDO_PATH same time
# -T: connect SUDO_PATH and sudo_path
typeset -xT SUDO_PATH sudo_path
sudo_path=(
  $sudo_path
  /opt/local/sbin(N-/)
  /opt/homebrew/sbin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
)

# ------------------------------------------------------------------------------ }}}

# MANPATH
# ------------------------------------------------------------------------------ {{{

manpath=(
  $HOME/.local/share/man(N-/)
  $HOME/.man(N-/)
  $HOME/perl5/man(N-/)
  /opt/homebrew/opt/curl/share/man(N-/)
  /opt/homebrew/opt/ncurses/share/man(N-/)
  /opt/homebrew/opt/sqlite/share/man(N-/)
  /opt/homebrew/opt/binutils/share/man(N-/)
  /opt/homebrew/opt/coreutils/libexec/gnuman(N-/)
  /opt/homebrew/opt/ed/libexec/gnuman(N-/)
  /opt/homebrew/opt/file-formula/share/man(N-/)
  /opt/homebrew/opt/findutils/libexec/gnuman(N-/)
  /opt/homebrew/opt/gettext/share/man(N-/)
  /opt/homebrew/opt/gnu-indent/libexec/gnuman(N-/)
  /opt/homebrew/opt/gnu-sed/libexec/gnuman(N-/)
  /opt/homebrew/opt/gnu-tar/libexec/gnuman(N-/)
  /opt/homebrew/opt/grep/libexec/gnuman(N-/)
  /opt/homebrew/opt/m4/share/man(N-/)
  /opt/homebrew/opt/make/libexec/gnuman(N-/)
  /opt/homebrew/opt/unzip/share/man(N-/)
  /opt/homebrew/opt/ssh-copy-id/share/man(N-/)
  /opt/homebrew/share/man(N-/)
  /usr/share/man(N-/)
  $manpath
)

# ------------------------------------------------------------------------------ }}}

# INFOPATH
# ------------------------------------------------------------------------------ {{{

# Tie INFOPATH and infopath together
typeset -T INFOPATH infopath

infopath=(
  /opt/homebrew/opt/binutils/share/info(N-/)
  /opt/homebrew/opt/m4/share/info(N-/)
  /opt/homebrew/share/info(N-/)
  /usr/share/info(N-/)
  $infopath
)

# ------------------------------------------------------------------------------ }}}

# PKG_CONFIG_PATH
# ------------------------------------------------------------------------------ {{{

# Tie PKG_CONFIG_PATH and pkg_config_path together
typeset -T PKG_CONFIG_PATH pkg_config_path

pkg_config_path=(
  /opt/homebrew/opt/openssl/lib/pkgconfig(N-/)
  /opt/homebrew/opt/libffi/lib/pkgconfig(N-/)
  /opt/homebrew/opt/curl/lib/pkgconfig(N-/)
  /opt/homebrew/opt/libxml2/lib/pkgconfig(N-/)
  /opt/homebrew/opt/libxslt/lib/pkgconfig(N-/)
  $pkg_config_path
)

# ------------------------------------------------------------------------------ }}}

# FPATH
# ------------------------------------------------------------------------------ {{{

fpath=(
  $ZDOTDIR/{functions,functions/{utils,prompts,zle},completions}(N-/)
  /opt/homebrew/share/zsh-completions(N-/)
  /usr/share/zsh/site-functions(N-/)
  $fpath
)

# ------------------------------------------------------------------------------ }}}

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
