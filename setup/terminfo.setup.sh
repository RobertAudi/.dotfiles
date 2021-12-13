#!/usr/bin/env zsh

/usr/bin/tic -x "${${(%):-%x}:A:h}/terminfo/tmux"
/usr/bin/tic -x "${${(%):-%x}:A:h}/terminfo/tmux-256color"
