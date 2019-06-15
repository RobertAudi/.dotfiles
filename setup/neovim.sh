#!/usr/bin/env zsh

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

# vim-plug {{{
# ---------------------------------------------------------------------

curl --fail --location \
  --output ${XDG_DATA_HOME:-~/.local/share}/nvim/site/autoload/plug.vim \
  --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || return $status

nvim --headless -e +PlugInstall +PlugUpgrade +PlugUpdate! +PlugClean! +qall &>/dev/null

# --------------------------------------------------------------------- }}}

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
