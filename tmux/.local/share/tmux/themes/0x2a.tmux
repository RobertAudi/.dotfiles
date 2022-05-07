# Status bar {{{
# ------------------------------------------------------------------------------

# default statusbar color
set-option -g status-style "bg=#2b2b2b"

set-option -g status-left         " #[fg=#5a647e, bg=#2b2b2b] #S #[default] "
set-option -g status-left-style   none
set-option -g status-left-length  60

set-option -g status-right        "#[fg=#5a647e, bg=#2b2b2b] %a #[fg=#f9f7f3]%H:%M #[fg=#5a647e] %d/%m/%Y #[default]"
set-option -g status-right-style  none
set-option -g status-right-length 60

# ------------------------------------------------------------------------------ }}}

# Panes {{{
# ------------------------------------------------------------------------------

set-option -g pane-border-style          "fg=#5a647e"
set-option -g pane-active-border-style   "fg=#5a647e"

# ------------------------------------------------------------------------------ }}}

# Messages {{{
# ------------------------------------------------------------------------------

set-option -g message-style   "fg=#2b2b2b,bg=#6d9cbe"

# ------------------------------------------------------------------------------ }}}

# Mode {{{
# ------------------------------------------------------------------------------

set-window-option -g mode-style     "fg=#2b2b2b,bg=#5a647e"

# ------------------------------------------------------------------------------ }}}

# Window {{{
# ------------------------------------------------------------------------------

set-window-option -g window-status-separator "#[fg=#5a647e]│#[fg=default]"
set-window-option -g window-status-bell-style       "fg=#da4939"
set-window-option -g window-status-activity-style   "fg=#6d9cbe"

set-window-option -g window-status-format    " #I:#W "
set-window-option -g window-status-style     "fg=#5a647e"

set-window-option -g window-status-current-format   " #[fg=#ffc66d]#I:#[fg=#e6e1dc]#W "
set-window-option -g window-status-current-style    "bg=#2b2b2b"

# ------------------------------------------------------------------------------ }}}
