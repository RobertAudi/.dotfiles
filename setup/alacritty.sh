#!/usr/bin/env zsh

source "${${(%):-%x}:A:h}/rust.sh"

builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"

command ghq get --update https://github.com/jwilm/alacritty.git

local project_root=$(command ghq list --exact --full-path github.com/jwilm/alacritty)

[[ -d "$project_root" ]] || return 1

(
  cd $project_root
  make app
  cp -rv target/release/osx/Alacritty.app /Applications/
  mkdir -pv /usr/local/share/man/man1
  gzip -c extra/alacritty.man | tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
  cp -v extra/completions/_alacritty ~/.dotfiles/alacritty/.zsh/completions/_alacritty
  cp -v extra/completions/alacritty.bash ~/.dotfiles/alacritty/.bash/alacritty-completions.bash
  make clean
)
