export CRENV_ROOT="$HOME/.crenv"
path=($CRENV_ROOT/bin(N-/) $path)

if is-callable crenv; then
  eval "$(crenv init -)"
fi
