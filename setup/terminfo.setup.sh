#!/usr/bin/env zsh

infocmp -A $(brew --prefix ncurses)/share/terminfo tmux >! "${${(%):-%x}:A:h}/terminfo/tmux"
infocmp -A $(brew --prefix ncurses)/share/terminfo tmux-256color >! "${${(%):-%x}:A:h}/terminfo/tmux-256color"

tic -x "${${(%):-%x}:A:h}/terminfo/tmux"
tic -x "${${(%):-%x}:A:h}/terminfo/tmux-256color"
