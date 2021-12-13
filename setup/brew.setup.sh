#!/usr/bin/env zsh

if type brew &>/dev/null; then
  builtin print -- "Updating Homebrew..."

  builtin print -P -- "%F{blue}==>%f brew update"
  command brew update
  builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"

  # --display-times
  #        Print install times for each formula at the end of the run.
  builtin print -P -- "%F{blue}==>%f brew upgrade --display-times"
  command brew upgrade --display-times
  builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"

  # Remove stale lock files and outdated downloads for formulae and casks,
  # and remove old versions of installed formulae.
  #
  # -s     Scrub the cache, including downloads for even the latest versions.
  #        Note downloads for any installed formula or cask will still not be deleted.
  #        If you want to delete those too: rm -rf "$(brew --cache)"
  #
  # --prune-prefix
  #        Only prune the symlinks and directories from the prefix and remove no other files.
  builtin print -P -- "%F{blue}==>%f brew cleanup -s --prune-prefix"
  command brew cleanup -s --prune-prefix
  builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"
else
  builtin print -- "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
