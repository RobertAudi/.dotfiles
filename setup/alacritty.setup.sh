#!/usr/bin/env zsh

if pgrep alacritty &>/dev/null; then
  builtin print -P -u 2 -- "[%F{red}ERROR%f] Alacritty is running! Please quit the app before updating it."
  return 1
fi

source "${${(%):-%x}:A:h}/rust.setup.sh"

builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"

command ghq get --update https://github.com/alacritty/alacritty.git

local project_root=$(command ghq list --exact --full-path github.com/alacritty/alacritty)

[[ -d "$project_root" ]] || return 1

(
  local mandir alacritty_dotfiles_dir
  mandir="${XDG_DATA_HOME-:$HOME/.local/share}/man/man1"
  alacritty_dotfiles_dir="${DOTFILES_DIR-:$HOME/.dotfiles}/alacritty"

  cd $project_root
  make app || return $status

  if [[ -e "/Applications/Alacritty.app" ]]; then
    mv -v "/Applications/Alacritty.app" "$HOME/.Trash"
  fi

  cp -frv target/release/osx/Alacritty.app /Applications/

  mkdir -pv "$mandir"
  gzip -c extra/alacritty.man | tee "${mandir}"/alacritty.1.gz > /dev/null
  cp -v extra/completions/_alacritty "${alacritty_dotfiles_dir}"/.zsh/completions/_alacritty
  cp -v extra/completions/alacritty.bash "${alacritty_dotfiles_dir}"/.bash/alacritty-completions.bash
  /usr/bin/tic -xe alacritty,alacritty-direct extra/alacritty.info
  make clean
)
