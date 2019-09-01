#!/usr/bin/env zsh

emulate -L zsh

setopt pipe_fail

if ! type nvim > /dev/null; then
  builtin print -P -- "%F{196}!!!%f Neovim is not installed" >&2
  return 1
fi

# Python {{{
# ---------------------------------------------------------------------

source "${${(%):-%x}:A:h}/python.sh"

pyenv install --skip-existing 3.7.2
pyenv install --skip-existing 2.7.15

pyenv virtualenv 3.7.2 neovim3
pyenv activate neovim3
pip install --upgrade pip
pip install --upgrade pynvim
pyenv deactivate neovim3

pyenv virtualenv 2.7.15 neovim2
pyenv activate neovim2
pip install --upgrade pip
pip install --upgrade pynvim
pyenv deactivate neovim2

# --------------------------------------------------------------------- }}}

# Ruby {{{
# ---------------------------------------------------------------------

source "${${(%):-%x}:A:h}/ruby.sh"

gem install neovim

# --------------------------------------------------------------------- }}}

# Node {{{
# ---------------------------------------------------------------------

npm install -g neovim

# --------------------------------------------------------------------- }}}

# Other dependencies {{{
# ---------------------------------------------------------------------

# markdown2ctags {{{
# ------------------
# Generate ctags-compatible tags files for Markdown documents.
#   https://github.com/jszakmeister/markdown2ctags
typeset markdown2ctagsURL="https://raw.githubusercontent.com/jszakmeister/markdown2ctags/master/markdown2ctags.py"
typeset markdown2ctagsDownlowdDir="${XDG_BIN_HOME-:$HOME/.local/bin}"

[[ -d "$markdown2ctagsDownlowdDir" ]] || mkdir -p "$markdown2ctagsDownlowdDir"

(builtin cd -q "${XDG_BIN_HOME-:$HOME/.local/bin}" && command curl -sqfLO "$markdown2ctagsURL")

if $status ; then
  chmod +x "${markdown2ctagsDownlowdDir}/markdown2ctags.py"
fi

unset markdown2ctagsURL markdown2ctagsDownlowdDir
# -------------- }}}

# --------------------------------------------------------------------- }}}

# vim-plug {{{
# ---------------------------------------------------------------------

curl --fail --location \
  --output ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim \
  --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || return $status

nvim --headless -e +PlugInstall +PlugUpgrade +PlugUpdate! +PlugClean! +qall &>/dev/null

# --------------------------------------------------------------------- }}}

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
