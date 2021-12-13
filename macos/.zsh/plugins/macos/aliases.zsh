# Open markdown files with marked
alias -s {md,mmd,markdown}="marked"

# Misc (random shit really...)
alias brews="brew list -1"

# Open web browsers easily
alias firefox="open -a Firefox"
alias safari="open -a Safari"

# Open Xcode project
alias xco="xcopen"

# Mute/Un-mute volume
alias mute="osascript -e 'set volume output muted true'"
alias unmute="osascript -e 'set volume output muted false'"

# Get battery level in %
alias "battery-percent"="pmset -g batt | egrep '([0-9]+%).*' -o --colour=auto | cut -f1 -d';'"

# Get battery remaining time
alias "battery-time"="pmset -g batt | egrep '([0-9]+%).*' -o --colour=auto | cut -f3 -d';'"

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"
alias pplist='plistbuddy -c print'

# alias to show all Mac App store apps
alias "appstore-apps"='mdfind "kMDItemAppStoreHasReceipt=1" | sort'

# Spotlight search in current dir
alias search="mdfind -onlyin \$PWD"

# Print the OS version
alias "macos-version"="sw_vers -productVersion"

# Print screen resolution on OS X
alias "screen-resolution"="system_profiler SPDisplaysDataType |  awk -F ':' '/Resolution/ {print \$2}'"

# CLI Airport
if [[ -x "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport" ]]; then
  alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
fi

# MailMate from the command line
if [[ -f "/Applications/MailMate.app/Contents/Resources/emate" && -x "/Applications/MailMate.app/Contents/Resources/emate" ]]; then
  alias emate="/Applications/MailMate.app/Contents/Resources/emate"
fi

if ! type pg >/dev/null; then
  # Aliases to control Postgres
  # Paths noted below are for Postgres installed via Homebrew on OSX
  # Source: OMZ postgres plugin

  alias pg="pg_ctl -D /usr/local/var/postgres"
  alias "pg-start"="pg start --log=/usr/local/var/postgres/server.log"
  alias "pg-stop"="pg stop --silent --mode=fast"
  alias "pg-restart"='pg restart --silent --mode=fast --wait'
  alias "pg-reload"="pg reload --silent"
  alias "pg-status"="pg status --silent"
fi

if type launch >/dev/null; then
  alias open="launch"
fi

if type flu.sh >/dev/null; then
  # Flush DNS cache
  alias flushdns="sudo flu.sh"
fi
