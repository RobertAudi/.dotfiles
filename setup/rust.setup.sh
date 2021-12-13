#!/usr/bin/env zsh

if ! type rustup >/dev/null; then
  local rustupScript="${${(%):-%x}:h}/rustup-init.sh"

  curl https://sh.rustup.rs --proto "=https" --tlsv1.2 -sSfLo "$rustupScript"

  sh $rustupScript --no-modify-path -y

  rm $rustupScript

  unset rustupScript
fi

rustup self update

rustup override set stable
rustup update stable
