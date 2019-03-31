#!/usr/bin/env zsh

if ! type brew &>/dev/null; then
  source "${${(%):-%x}:A:h}/brew.sh" || return $status
fi

if ! type ghq &>/dev/null; then
  brew install ghq || return $status
fi

if ! man -w ghq &>/dev/null; then
  if ! type asciidoctor &>/dev/null; then
    brew install asciidoctor || return $status
  fi

  local asciidoc_file="$(brew --prefix ghq)/ghq.txt"
  if [[ -f "$asciidoc_file" ]]; then
    asciidoctor -b manpage -o ${DOTFILES_DIR:-$HOME/.dotfiles}/git/.local/share/man/man1/ghq.1 $asciidoc_file
  fi
fi
