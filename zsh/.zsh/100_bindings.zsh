# Key info --------------------------------------------------------------------- {{{

# Use human-friendly identifiers.
typeset -gA key_info
key_info=(
  'Control'         '\C-'
  'ControlLeft'     '\e[1;5D \e[5D \e\e[D \eOd'
  'ControlRight'    '\e[1;5C \e[5C \e\e[C \eOc'
  'ControlPageUp'   '\e[5;5~'
  'ControlPageDown' '\e[6;5~'
  'Escape'          '\e'
  'Meta'            '\M-'
  'MetaLeft'        '[D'
  'MetaRight'       '[C'

  'Backspace'       "^?"
  'Delete'          "^[[3~"
  'Tab'             '^I'
  'BackTab'         "$terminfo[kcbt]"

  # Function keys
  'F1'              "$terminfo[kf1]"
  'F2'              "$terminfo[kf2]"
  'F3'              "$terminfo[kf3]"
  'F4'              "$terminfo[kf4]"
  'F5'              "$terminfo[kf5]"
  'F6'              "$terminfo[kf6]"
  'F7'              "$terminfo[kf7]"
  'F8'              "$terminfo[kf8]"
  'F9'              "$terminfo[kf9]"
  'F10'             "$terminfo[kf10]"
  'F11'             "$terminfo[kf11]"
  'F12'             "$terminfo[kf12]"
  'Insert'          "$terminfo[kich1]"
  'Home'            "$terminfo[khome]"
  'PageUp'          "$terminfo[kpp]"
  'End'             "$terminfo[kend]"
  'PageDown'        "$terminfo[knp]"

  # Arrows
  'Up'              "$terminfo[kcuu1]"
  'Left'            "$terminfo[kcub1]"
  'Down'            "$terminfo[kcud1]"
  'Right'           "$terminfo[kcuf1]"

  # Shift + Arrows
  'ShiftUp'         "$terminfo[kPRV]"
  'ShiftDown'       "$terminfo[kNXT]"
  'ShiftLeft'       "$terminfo[kLFT]"
  'ShiftRight'      "$terminfo[kRIT]"
)

# Set empty $key_info values to an invalid UTF-8 sequence to induce silent
# bindkey failure.
for key in "${(k)key_info[@]}"; do
  if [[ -z "$key_info[$key]" ]]; then
    key_info[$key]='�'
  fi
done
unset key

# ------------------------------------------------------------------------------ }}}

bindkey -e
bindkey -M emacs "$key_info[MetaLeft]"  backward-word
bindkey -M emacs "$key_info[MetaRight]" forward-word

bindkey -M emacs "$key_info[BackTab]"   reverse-menu-complete
bindkey -M emacs "$key_info[Control]]"  copy-prev-shell-word

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey -M emacs "$key_info[Backspace]" backward-delete-char
bindkey -M emacs "$key_info[Delete]"    delete-char

bindkey -M emacs "$key_info[Control]xe" edit-command-line
bindkey -M emacs "$key_info[Control]x$key_info[Control]e" edit-command-line

# Expand command name to full path.
bindkey -M emacs "$key_info[Escape]E" expand-cmd-path
bindkey -M emacs "$key_info[Escape]e" expand-cmd-path

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
