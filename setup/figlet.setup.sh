#!/usr/bin/env zsh

local figlet_fontdir
figlet_fontdir="$(brew --prefix figlet)/share/figlet/fonts"

[[ -n "$figlet_fontdir" && -d "$figlet_fontdir" ]] || { unset figlet_fontdir; return 1 }

local figlet_local_fontdir
figlet_local_fontdir="${XDG_DATA_HOME:-$HOME/.local/share}/figlet/fonts"

[[ -n "$figlet_local_fontdir" && -d "$figlet_local_fontdir" ]] || { unset figlet_fontdir figlet_local_fontdir; return 1 }

local f

for f in ${figlet_local_fontdir}/*.flf(N-.); do
  command ln -fsv ${f:A} ${figlet_fontdir}/${f:t}
done

if type toilet > /dev/null ; then
  local toilet_fontdir
  toilet_fontdir="$(brew --prefix toilet)/share/figlet"

  [[ -n "$toilet_fontdir" && -d "$toilet_fontdir" ]] || { unset figlet_fontdir figlet_local_fontdir toilet_fontdir f; return 1 }

  for f in ${toilet_fontdir}/*.tlf(N-.); do
    command ln -fsv ${f:A} ${figlet_fontdir}/${f:t}
  done
fi

unset figlet_fontdir figlet_local_fontdir toilet_fontdir f
