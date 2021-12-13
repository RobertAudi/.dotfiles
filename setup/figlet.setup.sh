#!/usr/bin/env zsh

local figlet_fontdir
figlet_fontdir="$(brew --prefix figlet)/share/figlet/fonts"

[[ -n "$figlet_fontdir" && -d "$figlet_fontdir" ]] || return 1

local figlet_local_fontdir
figlet_local_fontdir="${XDG_DATA_HOME:-$HOME/.local/share}/figlet/fonts"

[[ -n "$figlet_local_fontdir" && -d "$figlet_local_fontdir" ]] || return 1

local f

for f in ${figlet_local_fontdir}/*.flf(N-.); do
  command ln -fsv ${f:A} ${figlet_fontdir}/${f:t}
done

unset f
