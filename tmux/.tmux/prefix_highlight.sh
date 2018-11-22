#!/bin/bash

__tmux_prefix_highlight() {
  local suffix="…"
  local styles="fg=yellow bold"

  local original_status="$(tmux show-option -gqv "status-right")"
  local prefix="$(tmux show-option -gqv prefix | tr "[:lower:]" "[:upper:]" | sed "s/C-/\^/")"

  local active_value="#[${styles}]${prefix} ${suffix}#[default]"
  local inactive_value="$(printf "%${#prefix}s %${#suffix}s" "" "")"
  local status_value=" #{?client_prefix,${active_value},${inactive_value}}  "

  tmux set-option -gq "status-right" "${status_value}${original_status}"
}

__tmux_prefix_highlight
