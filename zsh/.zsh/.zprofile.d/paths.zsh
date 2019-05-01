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
  /Applications/Postgres.app/Contents/Versions/latest/bin(N-/)
  /usr/local/opt/ncurses/bin(N-/)
  /usr/local/opt/sqlite/bin(N-/)
  /usr/local/opt/llvm/bin(N-/)
  /usr/local/opt/ruby/bin(N-/)
  /usr/local/opt/python/libexec/bin(N-/)
  /usr/local/opt/binutils/bin(N-/)
  /usr/local/opt/coreutils/libexec/gnubin(N-/)
  /usr/local/opt/ed/libexec/gnubin(N-/)
  /usr/local/opt/file-formula/bin(N-/)
  /usr/local/opt/findutils/libexec/gnubin(N-/)
  /usr/local/opt/gettext/bin(N-/)
  /usr/local/opt/gnu-indent/libexec/gnubin(N-/)
  /usr/local/opt/gnu-sed/libexec/gnubin(N-/)
  /usr/local/opt/gnu-tar/libexec/gnubin(N-/)
  /usr/local/opt/grep/libexec/gnubin(N-/)
  /usr/local/opt/m4/bin(N-/)
  /usr/local/opt/make/libexec/gnubin(N-/)
  /usr/local/opt/nss/bin(N-/)
  /usr/local/opt/unzip/bin(N-/)
  /usr/local/bin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  /usr/local/sbin(N-/)
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
  /usr/local/sbin(N-/)
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
  /usr/local/opt/ncurses/share/man(N-/)
  /usr/local/opt/sqlite/share/man(N-/)
  /usr/local/opt/binutils/share/man(N-/)
  /usr/local/opt/coreutils/libexec/gnuman(N-/)
  /usr/local/opt/ed/libexec/gnuman(N-/)
  /usr/local/opt/file-formula/share/man(N-/)
  /usr/local/opt/findutils/libexec/gnuman(N-/)
  /usr/local/opt/gettext/share/man(N-/)
  /usr/local/opt/gnu-indent/libexec/gnuman(N-/)
  /usr/local/opt/gnu-sed/libexec/gnuman(N-/)
  /usr/local/opt/gnu-tar/libexec/gnuman(N-/)
  /usr/local/opt/grep/libexec/gnuman(N-/)
  /usr/local/opt/m4/share/man(N-/)
  /usr/local/opt/make/libexec/gnuman(N-/)
  /usr/local/opt/unzip/share/man(N-/)
  /usr/local/share/man(N-/)
  /Applications/Xcode.app/Contents/Developer/usr/share/man(N-/)
  /usr/share/man(N-/)
  $manpath
)

# ------------------------------------------------------------------------------ }}}

# INFOPATH
# ------------------------------------------------------------------------------ {{{

# Tie INFOPATH and infopath together
typeset -T INFOPATH infopath

infopath=(
  /usr/local/opt/binutils/share/info(N-/)
  /usr/local/opt/m4/share/info(N-/)
  /usr/local/share/info(N-/)
  /usr/share/info(N-/)
  $infopath
)

# ------------------------------------------------------------------------------ }}}

# FPATH
# ------------------------------------------------------------------------------ {{{

fpath=(
  $ZDOTDIR/{functions,functions/{utils,prompts},completions}(N-/)
  /usr/local/share/zsh-completions(N-/)
  /usr/share/zsh/site-functions(N-/)
  $fpath
)

# ------------------------------------------------------------------------------ }}}

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
