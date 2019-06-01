# XDG {{{
# ---------------------------------------------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_LIB_HOME="$HOME/.local/lib"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="$XDG_CACHE_HOME"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_DEVELOPER_DIR="$HOME/Developer"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_VIDEOS_DIR="$HOME/Videos"
# --------------------------------------------------------------------- }}}

export VIMPAGER_RC="$XDG_CONFIG_HOME/vimpager/vimpagerrc"

export DOTFILES_DIR="$HOME/.dotfiles"
export STOW_DIR="$DOTFILES_DIR"
export GOPATH="$XDG_DEVELOPER_DIR/go"

# ZSH {{{
# ---------------------------------------------------------------------
: ${ZDOTDIR:=$HOME/.zsh}
export ZSH_HOME="$ZDOTDIR"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
export ZSH_TMP_DIR="$TMPDIR/zsh"
export ZSH_LOCAL_DIR="$HOME/.local/zsh"
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump"
export ZSH_COMPCACHE="$ZSH_CACHE_DIR/zcompcache"

# Where zplugin lives
# See: https://github.com/zdharma/zplugin
export ZPLG_HOME="$HOME/.zplugin"
export ZPLG_LOADFILE="$ZSH_HOME/plugins/zplugin.zsh"
# --------------------------------------------------------------------- }}}

{
  /bin/mkdir -p -m 700   \
    "$XDG_CONFIG_HOME"   \
    "$XDG_CACHE_HOME"    \
    "$XDG_DATA_HOME"     \
    "$XDG_DEVELOPER_DIR" \
    "$ZSH_HOME"          \
    "$ZSH_CACHE_DIR"     \
    "$ZSH_TMP_DIR"       \
    "$ZSH_LOCAL_DIR"
} &!

# Watch for everybody but me
# And check every 5 min for login/logout activity
watch=(notme)
export LOGCHECK=302
export WATCHFMT='%n %a %l from %m at %t.'

# Less {{{
# ---------------------------------------------------------------------
# Set the Less input preprocessor.
typeset -g -a LESS_OPTIONS=(
  # Make the search smart case sensitive.
  --ignore-case

  # Disable EOF tilde (~) characters and use blank lines instead.
  --tilde

  # Truncate long lines and do not wrap them.
  --chop-long-lines

  # Display a status column at left edge of the screen.
  --status-column

  # Make status column more verbose.
  --LONG-PROMPT

  # Make target line the tenth line from top.
  --jump-target=10

  # Make the window scroll size 4 lines less than the current screen size
  --window=-4

  # Output ANSI escape sequences in their raw form.
  --RAW-CONTROL-CHARS

  # First line of the text should be always on top.
  --clear-screen

  # Highlight last match
  --hilite-search

  # Disable bell and use visual bell if available.
  --silent

  # Set tab length.
  --tabs=4

  # Specifies the default number of positions to scroll horizontally.
  --shift=5

  # Prompt format
  --prompt='?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
)

# Set options as string and remove temporary array.
export LESS="${LESS_OPTIONS[@]}" && unset LESS_OPTIONS

# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (($#commands[(i)lesspipe(|.sh)])); then
  export LESS="$LESS -X"
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# History file
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

export LESSCHARSET="utf-8"
export LESSSECURE=1
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)            # Begins blinking.
export LESS_TERMCAP_md=$(tput bold; tput setaf 1)            # Turn on bold mode.
export LESS_TERMCAP_me=$(tput sgr0)                          # Turn off all attributes.
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)               # Exit standout mode.
export LESS_TERMCAP_so=$(tput bold; tput setaf 3)            # Begin standout mode.
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 2) # Begin underline mode.
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)               # Exit underline mode.
export LESS_TERMCAP_mr=$(tput rev)                           # Turn on reverse video mode.
export LESS_TERMCAP_mh=$(tput dim)                           # Turn on half-bright mode.
export LESS_TERMCAP_ZN=$(tput ssubm)                         # Enter subscript mode.
export LESS_TERMCAP_ZV=$(tput rsubm)                         # End subscript mode.
export LESS_TERMCAP_ZO=$(tput ssupm)                         # Enter superscript mode.
export LESS_TERMCAP_ZW=$(tput rsupm)                         # End superscript mode.
# --------------------------------------------------------------------- }}}

# Grep {{{
# ---------------------------------------------------------------------
# Grep (BSD)
export GREP_COLOR='37;45' # 1;37

# Grep (GNU)
# Setting 'mt' is equivalent to setting both 'ms=' and 'mc=' at once to the same value.
export GREP_COLORS="mt=$GREP_COLOR:sl=:cx=:fn=1;33:ln=1;36:bn=1;35:se=1;30"
# --------------------------------------------------------------------- }}}

# Language {{{
# ---------------------------------------------------------------------
#
# I don't like the new locale settings.  If your distribution changes
# your locale, you will notice things like 'ls' are different.
#
# To see what you are currently using, type 'locale' in a console.
#
# LC_COLLATE affects the way 'ls' displays items.  If you leave it as
# en_US then it will intermix different cases and dot files.
#
# LC_TIME affects the way 'ls -l' displays items:
#
# This is using 'LC_TIME=en_US'
# -rw-r--r--  1 zyrnix zyrnix 144508 2005-04-04 04:49 Debian.jpg
#
# This is using the older style 'LC_TIME=C'
# -rw-r--r--  1 zyrnix zyrnix 144508 Apr  4  04:49 Debian.jpg
#
# These environment variables affect each locale categories for all
# locale-aware programs:
#
# LC_CTYPE           Character classification and case conversion.
# LC_COLLATE         Collation order.
# LC_TIME            Date and time formats.
# LC_NUMERIC         Non-monetary numeric formats.
# LC_MONETARY        Monetary formats.
# LC_MESSAGES        Formats of informative and diagnostic messages and
#                    interactive responses.
# LC_PAPER           Paper size.
# LC_NAME            Name formats.
# LC_ADDRESS         Address formats and location information.
# LC_TELEPHONE       Telephone number formats.
# LC_MEASUREMENT     Measurement units (Metric or Other).
# LC_IDENTIFICATION  Metadata about the locale information.
# LOCPATH            The directory where locale data is stored.
#                    The default is /usr/lib/locale.
export LANG=en_US.UTF-8
export LC_LANG=$LANG
export LC_CTYPE=$LANG
export LC_ALL=$LANG
export LC_COLLATE=C   # Display the old 'ls -a' formatting.
export LC_TIME=C      # Display the old 'ls -l' formatting.
# --------------------------------------------------------------------- }}}

# History {{{
# ---------------------------------------------------------------------
#
#   We keep histsize a bit larger
#   than savehist, to give the history
#   deduplication room to actually work.
#
export HISTFILE="$ZSH_CACHE_DIR/history"
export SAVEHIST=$(( 2 << 12 ))
export HISTSIZE=$(( $SAVEHIST + (1 << 10) ))

# # Make history more useful by ignoring short commands and aliases which don't
# # typically require options or commands
#
# # Editors
# HISTIGNORE="e:v:sb:$HISTIGNORE"
#
# # Git
# HISTIGNORE="g:gaa:gb:gba:gc:gca:gcaa:gcam:gci:gco:gd:gdi:gg:ggg:git:gl:gp:gst:$HISTIGNORE"
#
# # JS
# HISTIGNORE="gr:grw:n:ni:no:$HISTIGNORE"
#
# # Manipulation
# HISTIGNORE="rmcd:$HISTIGNORE"
#
# # Navigation
# HISTIGNORE=".:..:...:-:bin:c:cd:cod:d:dot:etc:h:l:ll:lll:lap:log:ls:lsd:lsf:lsl:lst:lss:lt:lts:opt:p:rcd:rt:sbin:site:ubin:usbin:usr:var:vimf:$HISTIGNORE"
#
# # OSX
# HISTIGNORE="lk:thumb:$HISTIGNORE"
#
# # Ruby
# HISTIGNORE="irb:pry:b:f:migrate:m:rk:s:t:$HISTIGNORE"
#
# # System
# HISTIGNORE="et:exit:path:r:$HISTIGNORE"
#
# # Util
# HISTIGNORE="tags:tm:tmi:$HISTIGNORE"
#
# # bin, sbin
# HISTIGNORE="bash:bc:cal:date:df:du:j:pwd:tree:who:whoami:$HISTIGNORE"
#
# # ~/bin
# HISTIGNORE="fs:tre:wifi:$HISTIGNORE"
#
# --------------------------------------------------------------------- }}}

# The format of process time reports with the time builtin.
#     %%     A `%'.
#     %U     CPU seconds spent in user mode.
#     %S     CPU seconds spent in kernel mode.
#     %E     Elapsed time in seconds.
#     %P     The CPU percentage, computed as  (%U+%S)/%E.
#     %J     The name of this job.
#
# Default is:
#     %E real  %U user  %S system   %P  %J
export TIMEFMT="%E real        %U user        %S sys"

# Report time statistics for commands
# that take too long to run
export REPORTTIME=10

# Limit this fuckung "zsh: do you wish to see all NNN possibilities (NNN
# lines)?" downward (default is 100). Only ask before displaying
# completions if doing so would scroll.
export LISTMAX=200

# Treat these characters as part of a word.
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>|'

# Use 1024-byte (1-Kbyte) blocks, rather than the default (512-byte).
# Used by df and du
export BLOCKSIZE=k

# Character set for tree to use in HTML mode.
export TREE_CHARSET=UTF-8

# Editor {{{
# ---------------------------------------------------------------------
export EDITOR="${VIM_COMMAND:-vim}"
export VISUAL="$EDITOR"
export GIT_EDITOR="$VISUAL"
export SUDO_EDITOR="$VISUAL"
export BUNDLER_EDITOR="$VISUAL"
export GEMEDITOR="$VISUAL"
# --------------------------------------------------------------------- }}}

if [[ -z "$HELPDIR" && -d "/usr/local/share/zsh/help" ]]; then
  export HELPDIR=/usr/local/share/zsh/help
fi

# ENV variables
export CHEATCOLORS=true
export CLICOLOR=true
export PAGER="smartless"
export MANPAGER="less"
export BROWSER="open"
export IMAGE_VIEWER="open"
export PDF_READER="open"
export DOWNLOADS_DIR="$HOME/Downloads/_hazel"
export QT_STYLE_OVERRIDE=adwaita
export WALLPAPER="$XDG_DATA_HOME/resources/wallpaper.png"
export PROJECTS="$HOME/Developer"
unset DISPLAY

# If we're 64bit, let everything know!
[[ "x86_64" == "$(/usr/bin/uname -m)" ]] && export ARCHFLAGS="-arch x86_64 ${ARCHFLAGS}"

# Readline config
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

# Ack config file path
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"

# ripgrep (rg) config file path
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgreprc"

# cURL config file assuming XDG Base Directory setup
export CURL_HOME="$XDG_CONFIG_HOME/curl"

# npm global configuration file
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# Homebrew {{{
# ---------------------------------------------------------------------
# Text printed before the installation summary of each successful build.
export HOMEBREW_INSTALL_BADGE="🔮✨"

# Do not use the GitHub API for e.g searches or fetching relevant issues on a failed install.
export HOMEBREW_NO_GITHUB_API=1

# Do not send analytics
export HOMEBREW_NO_ANALYTICS=1

# Do not auto-update before running brew install, brew upgrade or brew tap.
export HOMEBREW_NO_AUTO_UPDATE=1

# Do not permit redirects from secure HTTPS to insecure HTTP.
export HOMEBREW_NO_INSECURE_REDIRECT=1
# --------------------------------------------------------------------- }}}

# JAVA home
if [[ -f /usr/libexec/java_home ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
