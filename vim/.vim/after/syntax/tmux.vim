syntax keyword raTmuxModeCmds copy-pipe-and-cancel select-line select-word

syntax keyword raTmuxOptsSet status-style status-left-style status-right-style
syntax keyword raTmuxOptsSet pane-border-style pane-active-border-style
syntax keyword raTmuxOptsSet window-status-bell-style window-status-activity-style
syntax keyword raTmuxOptsSet window-status-style window-status-current-style
syntax keyword raTmuxOptsSet message-style mode-style

syntax match raTmuxKeyTable /\s\(-T\)\?root/ display
syntax match raTmuxKeyTable /\s\(-T\)\?copy-mode\(-vi\)\?/ display

highlight def link raTmuxWindowPaneCmds tmuxWindowPaneCmds
highlight def link raTmuxModeCmds       tmuxModeCmds
highlight def link raTmuxKeyTable       tmuxKeyTable
highlight def link raTmuxOptsSet        tmuxOptsSet
