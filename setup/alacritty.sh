#!/usr/bin/env zsh

source "${${(%):-%x}:A:h}/rust.sh"

builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"

command ghq get --update https://github.com/jwilm/alacritty.git

local project_root=$(command ghq list --exact --full-path github.com/jwilm/alacritty)

[[ -d "$project_root" ]] || return 1

(
  local mandir alacritty_dotfiles_dir
  mandir="${XDG_DATA_HOME-:$HOME/.local/share}/man/man1"
  alacritty_dotfiles_dir="${DOTFILES_DIR-:$HOME/.dotfiles}/alacritty"

  cd $project_root
  make app
  cp -rv target/release/osx/Alacritty.app /Applications/
  mkdir -pv "$mandir"
  gzip -c extra/alacritty.man | tee "${mandir}"/alacritty.1.gz > /dev/null
  cp -v extra/completions/_alacritty "${alacritty_dotfiles_dir}"/.zsh/completions/_alacritty
  cp -v extra/completions/alacritty.bash "${alacritty_dotfiles_dir}"/.bash/alacritty-completions.bash
  make clean
)
