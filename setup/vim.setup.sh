#!/usr/bin/env zsh

if [[ -d ~/.vim/pack/tpope/start/sensible ]]; then
  (cd -q ~/.vim/pack/tpope/start/sensible && git pull --all)
else
  mkdir -p ~/.vim/pack/tpope/start
  git clone https://tpope.io/vim/sensible.git ~/.vim/pack/tpope/start/sensible
fi

vim -u NONE -c "helptags sensible/doc" -c q
