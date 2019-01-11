#!/usr/bin/env -i HOME="$HOME" TERM="$TERM" zsh

if type brew &>/dev/null; then
  print -- "Updating Homebrew..."
  brew update
else
  print -- "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
