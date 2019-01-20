#!/usr/bin/env zsh

command ghq get --update https://github.com/jwilm/alacritty.git

local project_root=$(command ghq list --exact --full-path github.com/jwilm/alacritty)

[[ -d "$project_root" ]] || return 1

(
  cd $project_root
  make app
  cp -rv target/release/osx/Alacritty.app /Applications/
  mkdir -pv /usr/local/share/man/man1
  gzip -c alacritty.man | tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
  cp -v alacritty-completions.zsh ~/.dotfiles/alacritty/.zsh/completions/_alacritty
  cp -v alacritty-completions.bash ~/.dotfiles/alacritty/.bash/alacritty-completions.bash
  sudo tic -e alacritty,alacritty-direct alacritty.info
  make clean
)
