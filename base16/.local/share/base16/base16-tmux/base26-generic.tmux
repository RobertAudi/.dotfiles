# base16-generic

# Status bar {{{
# ------------------------------------------------------------------------------

set-option -g status-style "bg=black"

set-option -g status-left         "  #S  "
set-option -g status-left-style   "fg=brightblack,bg=black"
set-option -g status-left-length  60

set-option -g status-right        " %a #[fg=#f9f7f3]%H:%M #[fg=brightblack] %d/%m/%Y #[default]"
set-option -g status-right-style  "fg=brightblack,bg=black"
set-option -g status-right-length 60

# ------------------------------------------------------------------------------ }}}

# Panes {{{
# ------------------------------------------------------------------------------

set-option -g pane-border-style          "fg=brightblack"
set-option -g pane-active-border-style   "fg=brightblack"

# ------------------------------------------------------------------------------ }}}

# Messages {{{
# ------------------------------------------------------------------------------

set-option -g message-style   "fg=black,bg=blue"

# ------------------------------------------------------------------------------ }}}

# Mode {{{
# ------------------------------------------------------------------------------

set-window-option -g mode-style     "fg=black,bg=brightblack"

# ------------------------------------------------------------------------------ }}}

# Window {{{
# ------------------------------------------------------------------------------

set-window-option -g window-status-separator "#[fg=brightblack]┊#[fg=default]"
set-window-option -g window-status-bell-style       "fg=red"
set-window-option -g window-status-activity-style   "fg=blue"

set-window-option -g window-status-format    " #I:#W "
set-window-option -g window-status-style     "fg=brightblack"

set-window-option -g window-status-current-format   " #[fg=yellow]#I:#[fg=white]#W "
set-window-option -g window-status-current-style    "bg=black"

# ------------------------------------------------------------------------------ }}}
