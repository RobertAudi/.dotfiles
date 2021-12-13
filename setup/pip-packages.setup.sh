#!/usr/bin/env zsh

# Utils {{{
# ------------------------------------------------------------------------------

function ___install {
  builtin print -P -- "%F{blue}==>%f pip install --upgrade --upgrade-strategy eager --progress-bar pretty \"$@\""

  env CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix readline)/include" \
    LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib" \
    PKG_CONFIG_PATH="$(brew --prefix openssl)/lib/pkgconfig:$(brew --prefix readline)/lib/pkgconfig" \
    pip install --upgrade --upgrade-strategy eager --progress-bar pretty "$@"
}

# ------------------------------------------------------------------------------ }}}

# The Python Package Installer, Build tool and Wheel
___install pip setuptools wheel

# IPython provides a rich architecture for interactive computing
#   https://ipython.org/index.html
___install ipython

# Fast and Highly Extensible Vim script Language Lint implemented in Python.
#   https://github.com/Kuniwak/vint
___install vim-vint
