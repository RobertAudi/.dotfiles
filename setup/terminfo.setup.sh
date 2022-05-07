#!/usr/bin/env zsh

# infocmp -A /usr/local/opt/ncurses/share/terminfo tmux
# infocmp -A /usr/local/opt/ncurses/share/terminfo tmux-256color

/usr/bin/tic -x "${${(%):-%x}:A:h}/terminfo/tmux"
/usr/bin/tic -x "${${(%):-%x}:A:h}/terminfo/tmux-256color"
