export TSM_HOME="$XDG_DATA_HOME/tsm"
export TSM_SESSIONS_DIR="$TSM_HOME/sessions"
export TSM_BACKUPS_DIR="$TSM_HOME/backups"
export TSM_BACKUPS_COUNT=10

# is-tmux-runnning returns true if tmux is running
function is-tmux-runnning() { [[ -n $TMUX ]] }

if is-tmux-runnning; then
  alias vs="tmux split-window -h"
  alias ss="tmux split-window"
  alias cs="tmux new-window"
  alias fls="tmux list-sessions -F \"#{session_name}\""
fi
