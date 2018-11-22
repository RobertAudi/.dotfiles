#!/usr/bin/env zsh

# See https://github.com/direnv/direnv/wiki/Tmux
if type direnv &>/dev/null; then
  tmux set-option -g update-environment "DIRENV_DIFF DIRENV_DIR DIRENV_WATCHES"
  tmux set-environment -gu DIRENV_DIFF
  tmux set-environment -gu DIRENV_DIR
  tmux set-environment -gu DIRENV_WATCHES
  tmux set-environment -gu DIRENV_LAYOUT
fi
