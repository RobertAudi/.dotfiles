export TMUX_SESSIONS_HOME="$HOME/.tmux/tmux-sessions"
export TMUX_SESSIONS_SESSIONS_DIR="$TMUX_SESSIONS_HOME/sessions"
export TMUX_SESSIONS_BACKUPS_DIR="$TMUX_SESSIONS_HOME/backups"
export TMUX_SESSIONS_BACKUPS_COUNT=10

# is-tmux-runnning returns true if tmux is running
function is-tmux-runnning() { [[ -n $TMUX ]] }

if is-tmux-runnning; then
  alias vs="tmux split-window -h"
  alias ss="tmux split-window"
  alias cs="tmux new-window"
  alias fls="tmux list-sessions -F \"#{session_name}\""
fi
