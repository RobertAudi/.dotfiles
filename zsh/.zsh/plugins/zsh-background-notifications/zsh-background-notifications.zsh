#######################################################################
#                                Setup                                #
#######################################################################

# Only do this if we're in an interactive shell
[[ -o interactive ]] || return

# get $EPOCHSECONDS. builtins are faster than date(1)
zmodload zsh/datetime || { print "Can't load zsh/datetime"; return }

# make sure we can register hooks
autoload -Uz add-zsh-hook || { print "can't add zsh hook!"; return }

# Config variables
typeset -ga BG_NOTIFICATIONS_IGNORED_COMMANDS
typeset -x  BG_NOTIFICATIONS_THRESHOLD

# initialize it because otherwise we compare a date and an empty string
# the first time we see the prompt. it's fine to have lastcmd empty on the
# initial run because it evaluates to an empty string, and splitting an
# empty string just results in an empty array.
bg_notifications_timestamp=$EPOCHSECONDS

#######################################################################
#                             Definitions                             #
#######################################################################

# Allow custom function override
if ! (type send-formatted-bg-notification | grep -q "function"); then
  # args: (exit_status, command, elapsed_seconds)
  send-formatted-bg-notification() {
    local message
    local elapsed="$(( $3 % 60 ))s"

    (( $3 >= 60 ))   && elapsed="$((( $3 % 3600) / 60 ))m $elapsed"
    (( $3 >= 3600 )) && elapsed="$((  $3 / 3600 ))h $elapsed"

    [ $1 -eq 0 ] && message="#win (took $elapsed)" || message="#fail (took $elapsed)"

    bg-notifications-notify "$message" "$2"
  }
fi

# bg-notifications-ignored-command <command>
bg-notifications-ignored-command() {
  BG_NOTIFICATIONS_IGNORED_COMMANDS+="$1"
}

bg-notifications-get-current-window-id() {
  if hash osascript 2>/dev/null; then
    osascript -e 'tell application (path to frontmost application as text) to id of front window' 2&> /dev/null || echo "0"
  elif (hash notify-send 2>/dev/null); then
    xprop -root 2> /dev/null | awk '/^_NET_ACTIVE_WINDOW/{print $5;exit} END{exit !$5}' || echo "0"
  else
    echo $EPOCHSECONDS
  fi
}

# args: (title, subtitle)
bg-notifications-notify() {
  if hash terminal-notifier 2>/dev/null; then
    local term_id

    [[ "$TERM_PROGRAM" == "iTerm.app" ]]      && term_id='com.googlecode.iterm2'
    [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && term_id='com.apple.terminal'

    # now call terminal-notifier, (hopefully with $term_id!)
    [[ -z "$term_id" ]] && terminal-notifier -message "$2" -title "$1" >/dev/null || return $?

    terminal-notifier -message "$2" -title "$1" -activate "$term_id" -sender "$term_id" >/dev/null
  elif hash notify-send 2>/dev/null; then
    notify-send "$1" "$2"
  fi
}

#######################################################################
#                              ZSH Hooks                              #
#######################################################################

# right before we begin to execute something, store the time it started at
bg-notifications-start-monitoring() {
  bg_notifications_timestamp=$EPOCHSECONDS
  bg_notifications_lastcmd="$1"
  bg_notifications_windowid=$(bg-notifications-get-current-window-id)
}

# when it finishes, if it's been running longer than $BG_NOTIFICATIONS_THRESHOLD,
# and we dont have an ignored command in the line, then print a bell.
bg-notifications-stop-monitoring() {
  local didexit=$?
  local elapsed=$(( EPOCHSECONDS - bg_notifications_timestamp ))
  local past_threshold=$(( elapsed >= BG_NOTIFICATIONS_THRESHOLD ))

  local cmd words util
  local has_ignored_cmd=0
  for cmd in ${(s:;:)bg_notifications_lastcmd//|/;}; do
    words=(${(z)cmd})
    util=${words[1]}
    if (( ${BG_NOTIFICATIONS_IGNORED_COMMANDS[(i)$util]} <= ${#BG_NOTIFICATIONS_IGNORED_COMMANDS} )); then
      has_ignored_cmd=1
      break
    fi
  done

  if (( ! $has_ignored_cmd )) && (( bg_notifications_timestamp > 0 )) && (( past_threshold )); then
    if [ $(bg-notifications-get-current-window-id) != "$bg_notifications_windowid" ]; then
      print -n "\a"
      send-formatted-bg-notification "$didexit" "$bg_notifications_lastcmd" "$elapsed"
    fi
  fi

  # Reset the timestamp to 0!
  bg_notifications_timestamp=0
}

# Register the functions as hooks
# Only enable if a local (non-ssh) connection
if [[ -z "$SSH_CLIENT" ]] && [[ -z "$SSH_TTY" ]]; then
  add-zsh-hook preexec bg-notifications-start-monitoring
  add-zsh-hook precmd  bg-notifications-stop-monitoring
fi

#######################################################################
#                            Configuration                            #
#######################################################################

# Add default commands to the Ignore List
bg-notifications-ignored-command "$EDITOR"
bg-notifications-ignored-command "$PAGER"

# Default wait time: 10 seconds
export BG_NOTIFICATIONS_THRESHOLD=${BG_NOTIFICATIONS_THRESHOLD:=10}
