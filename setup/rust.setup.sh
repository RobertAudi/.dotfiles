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

builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"

if ! cargo install --list | grep -q 'cargo-update'; then
  builtin print -P -- "%F{blue}==>%f Installing cargo-update"
  cargo install cargo-update || return $?

  builtin print -Pn -- "%B%F{019}"; hr "⋅"; builtin print -Pn -- "%f%b"
fi

# rustup override set nightly
# rustup update nightly
