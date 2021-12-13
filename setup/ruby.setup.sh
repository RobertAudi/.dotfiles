#!/usr/bin/env zsh

if ! type ruby-install >/dev/null; then
  builtin print -P -u 2 -- "[%F{196}ERROR%f] Missing requirement: %Bruby-install%b"
  builtin print -P -u 2 -- "See https://github.com/postmodern/ruby-install#readme"
  return 1
fi

local number_of_cores=$(sysctl -n hw.ncpu)
local src_dir="${XDG_CACHE_HOME:-$HOME/.cache}/rubies"

local ruby_version
if [[ -f "$HOME/.ruby-version" ]]; then
  ruby_version="$(cat "$HOME/.ruby-version")"
else
  ruby_version="ruby"
fi

command ruby-install --latest

# ruby-install: Remove sources, archives, and all that shit.
#
# Options:
#   --jobs=JOBS         Number of jobs to run in parallel when compiling
#   --src-dir DIR       Directory to download source-code into
#   --cleanup           Remove archive and unpacked source-code after installation
#   --no-reinstall      Skip installation if another Ruby is detected in same location
env CPPFLAGS="-I/opt/homebrew/opt/openssl/include" \
  LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib -L/opt/homebrew/opt/libffi/lib" \
  PKG_CONFIG_PATH="/opt/homebrew/opt/openssl/lib/pkgconfig:/opt/homebrew/opt/libffi/lib/pkgconfig" \
  command ruby-install \
  --jobs=$number_of_cores \
  --src-dir $src_dir \
  --cleanup \
  --no-reinstall \
  $ruby_version \
  -- --with-openssl-dir=$(brew --prefix openssl@1.1)
