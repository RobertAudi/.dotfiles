#!/usr/bin/env zsh

if type mint >/dev/null; then
  # Because, yes, sometimes I really am so lazy that I want to cd
  # and just open whatever xcproj is in the folder
  #   https://github.com/erica/xcopen
  mint install erica/xcopen
else
  builtin print -P -u 2 -- "[%F{196}ERROR%f] Command not found: mint"
fi

(
  local installation_tmpdir
  installation_tmpdir=$(mktemp --directory --quiet 2> /dev/null) || return $status

  local download_url
  download_url="https://github.com/slavaGanzin/await/releases/download/0.9/await-macos"

  command curl --silent --disable --fail --location --output "${installation_tmpdir}/await" "$download_url" || return $status
  command chmod --silent +x "${installation_tmpdir}/await"
  command mv --force "${installation_tmpdir}/await" "${XDG_BIN_HOME}/await"
)
