#!/usr/bin/env zsh

emulate -L zsh

setopt pipe_fail

local -A opts
zparseopts -D -E -A opts -init

if ! type nvim > /dev/null; then
  if (( ${+opts[--init]} )); then
    brew bundle install --file="${${(%):-%x}:A:h}/Homebrew/vim.brewfile"
  else
    builtin print -P -- "%F{196}!!!%f Neovim is not installed" >&2
    return 1
  fi
fi

# Python {{{
# ---------------------------------------------------------------------

if (( ${+opts[--init]} )); then
  source "${${(%):-%x}:A:h}/python.setup.sh"
fi

pyenv install --skip-existing 3.10.0

pyenv virtualenv 3.10.0 neovim3
pyenv activate neovim3
pip install --upgrade pip
pip install --upgrade pynvim
pip install --upgrade vim-vint
pip install --upgrade yamllint
pyenv deactivate neovim3

# --------------------------------------------------------------------- }}}

# Ruby {{{
# ---------------------------------------------------------------------

if (( ${+opts[--init]} )); then
  source "${${(%):-%x}:A:h}/ruby.setup.sh"
fi

gem install neovim \
  solargraph \
  erb_lint \
  standard

# --------------------------------------------------------------------- }}}

# Node {{{
# ---------------------------------------------------------------------

npm install -g \
  neovim \
  tree-sitter \
  tree-sitter-toml \
  vim-language-server \
  typescript \
  typescript-language-server \
  vfile-reporter \
  remark-cli \
  remark-gfm \
  prettier \
  @fsouza/prettierd \
  stylelint \
  stylelint-config-recommended \
  @taplo/cli

# --------------------------------------------------------------------- }}}

# Lua {{{
# ---------------------------------------------------------------------

if (( ${+opts[--init]} )); then
  source "${${(%):-%x}:A:h}/lua.setup.sh"
fi

# Install the lua language server
# Repo: https://github.com/sumneko/lua-language-server
function {
  emulate -L zsh

  setopt pipe_fail

  if ! (( $+commands[ninja] )) &>/dev/null; then
    command brew install ninja
  fi

  : ${LUA_LSP_HOME:=${HOME}/.local/opt/lua-language-server}
  export LUA_LSP_HOME

  if [[ ! -d $LUA_LSP_HOME ]]; then
    command git clone https://github.com/sumneko/lua-language-server $LUA_LSP_HOME
  fi

  builtin cd -q $LUA_LSP_HOME

  command git pull
  command git submodule update --init --recursive

  builtin cd -q 3rd/luamake

  ninja -f compile/ninja/macos.ninja

  unalias luamake &> /dev/null
  alias luamake="${LUA_LSP_HOME}/3rd/luamake/luamake"

  builtin cd -q ../..

  ./3rd/luamake/luamake rebuild
}

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

if (( $status == 0 )) ; then
  chmod +x "${markdown2ctagsDownlowdDir}/markdown2ctags.py"
fi

unset markdown2ctagsURL markdown2ctagsDownlowdDir
# -------------- }}}

#  Static checker for GitHub Actions workflow files
#   https://rhysd.github.io/actionlint
brew install actionlint

# Experimental linter/analyzer for Makefiles
#   https://github.com/mrtazz/checkmake
brew install checkmake

# Lightweight and flexible command-line JSON processor
#   https://stedolan.github.io/jq/
brew install jq

# --------------------------------------------------------------------- }}}

if (( ${+opts[--init]} )); then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/packer/start/packer.nvim || return $status

  nvim --headless -e +PackerSync +qall &>/dev/null
fi

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
