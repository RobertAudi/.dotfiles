# Modules {{{
# ------------------------------------------------------------------------------

# Builtins for manipulating extended attributes (xattr).
zmodload zsh/attr

# Completion listing extensions.
zmodload zsh/complist

# Some date/time commands and parameters.
zmodload zsh/datetime

# Standard scientific functions for use in mathematical evaluations.
zmodload zsh/mathfunc

# Access to internal hash tables via special associative arrays.
zmodload zsh/parameter

# Builtins for managing private-scoped parameters in function context.
zmodload zsh/param/private

# Interface to the PCRE library.
zmodload zsh/pcre

# A builtin interface to various low-level system features.
zmodload zsh/system

# Interface to the terminfo database.
zmodload zsh/terminfo

# A builtin command interface to the stat system call.
zmodload -F zsh/stat b:zstat

# ------------------------------------------------------------------------------ }}}

# Options {{{
# ------------------------------------------------------------------------------
autoload -Uz is-at-least

# Changing Directories
# --------------------
setopt auto_cd           # Auto changes to a directory without typing cd.
setopt auto_pushd        # Make cd push the old directory onto the directory stack.
setopt cdable_vars       # Change directory to a path stored in a variable.
setopt pushd_ignore_dups # Don't push multiple copies of the same directory onto the directory stack.
setopt pushd_minus       # Exchanges the meanings of '+' and '-' when used with a number to specify a directory in the stack.
setopt pushd_silent      # Do not print the directory stack after pushd or popd.
setopt pushd_to_home     # Have pushd with no arguments act like `pushd $HOME'.

# Completion
# ----------
setopt always_to_end      # Move cursor to the end of a completed word.
setopt auto_list          # Automatically list choices on ambiguous completion.
setopt auto_menu          # Show completion menu on a succesive tab press.
setopt auto_param_slash   # If completed parameter is a directory, add a trailing slash.
setopt auto_remove_slash  # Remove trailing slash when appropriate.
setopt complete_in_word   # Complete from both ends of a word.
setopt list_packed        # To make the completion list smaller by printing the matches in columns with different widths.
setopt menu_complete      # Autoselect the first completion entry (so that I can use arrow keys right away).

setopt NO_auto_name_dirs  # DO NOT Auto add variable-stored paths to ~ list.
setopt NO_list_rows_first # Lay out the matches in completion lists sorted vertically.

# Expansion and Globbing
# ----------------------
setopt extended_glob     # Use extended globbing syntax.
setopt glob_dots         # Do not require a leading `.' in a filename to be matched explicitly.
setopt mark_dirs         # Append a trailing '/' to all directory names resulting from filename generation (globbing).
setopt numeric_glob_sort # Sort the filenames numerically rather than lexicographically.
setopt rematch_pcre      # Use PCRE regular expressions when matching with the =~ operator.

if is-at-least 5.2; then
  # the pattern '**/*'  can be abbreviated to '**' and
  # the pattern '***/*' can be abbreviated to '***'
  setopt glob_star_short
fi

setopt NO_case_glob      # Case insensitive globbing

# History
# -------
setopt append_history         # Allow multiple terminal sessions to all append to one zsh command history
setopt bang_hist              # Treat the '!' character specially during expansion.
setopt extended_history       # Write the history file in the ':start:elapsed;command' format.
setopt hist_expire_dups_first # Expire a duplicate event first when trimming history.
setopt hist_find_no_dups      # Do not display a previously found event.
setopt hist_ignore_all_dups   # Delete an old recorded event if a new event is a duplicate.
setopt hist_ignore_dups       # Do not record an event that was just recorded again.
setopt hist_ignore_space      # Do not record an event starting with a space.
setopt hist_no_store          # Remove the history (fc -l) command from the history list when invoked.
setopt hist_reduce_blanks     # Remove superfluous blanks from commands added to the history list.
setopt hist_save_no_dups      # Do not write a duplicate event to the history file.
setopt hist_verify            # Do not execute immediately upon history expansion.
setopt share_history          # Share history between all sessions.

# Input/Output
# ------------
setopt path_dirs         # Perform path search even on command names with slashes.
setopt rm_star_wait      # 10 second wait when using rm with a glob

setopt NO_rm_star_silent # Always query the user before executing `rm *' or `rm path/*'.
setopt NO_clobber        # Do not overwrite existing files with > and >>. Use >! and >>! to bypass.
setopt NO_flow_control   # Disable start/stop characters in shell editor.

# Job Control
# -----------
setopt auto_continue  # Stopped jobs that are removed from the job table with the disown builtin command are
                      #  automatically sent a CONT signal to make them running.
setopt auto_resume    # Attempt to resume existing job before creating a new process.
setopt long_list_jobs # List jobs in the long format by default.
setopt monitor        # Allow job control
setopt notify         # Report status of background jobs immediately.

setopt NO_bg_nice     # Don't run all background jobs at a lower priority.
setopt NO_check_jobs  # Don't report on jobs when shell exit.
setopt NO_hup         # Don't kill jobs on shell exit.

# Prompt
# ------
setopt prompt_subst # Substitutions within prompts do not affect the command status.

# Scripting
# ---------
# setopt c_bases      # Output hexadecimal numbers in the standard C format, for example '0xFF'
setopt multios      # Write to multiple descriptors.
# setopt octal_zeroes # Output octal numbers in the standard C format, for example '077'
setopt pipe_fail    # Set the exit status of failed commands to the rightmost element of the pipeline that was non-zero

# Zle
# ---
setopt NO_beep # SHUT THE FUCK UP!!!
# ------------------------------------------------------------------------------ }}}

# Autoloads {{{
# ------------------------------------------------------------------------------
autoload -Uz zmv
autoload -Uz add-zsh-hook
autoload -Uz colors && colors

# This logic comes from an old version of zim. Essentially, bracketed-paste was
# added as a requirement of url-quote-magic in 5.1, but in 5.1.1 bracketed
# paste had a regression. Additionally, 5.2 added bracketed-paste-url-magic
# which is generally better than url-quote-magic so we load that when possible.
if [[ ${ZSH_VERSION} != 5.1.1 ]]; then
  if is-at-least 5.2; then
    autoload -Uz bracketed-paste-url-magic
    zle -N bracketed-paste bracketed-paste-url-magic
  else
    if is-at-least 5.1; then
      autoload -Uz bracketed-paste-magic
      zle -N bracketed-paste bracketed-paste-magic
    fi
  fi
  autoload -Uz url-quote-magic
  zle -N self-insert url-quote-magic
fi

autoload -Uz edit-command-line && zle -N edit-command-line
autoload -Uz smart-insert-last-word && zle -N insert-last-word smart-insert-last-word
autoload -Uz zcalc
autoload -Uz zstyle+ && alias zstyle="zstyle+"

# Like xargs, but instead of reading lines of arguments from standard input,
# it takes them from the command line. This is possible/useful because,
# especially with recursive glob operators, zsh often can construct a command
# line for a shell function that is longer than can be accepted by an external
# command. This is what's often referred to as the "shitty Linux exec limit" ;)
# The limitation is on the number of characters or arguments.
#  $ =echo {1..30000}
#  zsh: argument list too long: /bin/echo
#  $ autoload -U zargs
#  $ zargs -- =echo {1..30000}
#  [ long list ;) ]
autoload -Uz zargs
# ------------------------------------------------------------------------------ }}}

# Completion {{{
# ------------------------------------------------------------------------------
# Load and initialize the completion system
# ignoring insecure directories.
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r "$ZSH_COMPDUMP" 2>/dev/null || stat -f '%Sm' -t '%j' "$ZSH_COMPDUMP" 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i -u -d "$ZSH_COMPDUMP"
else
  compinit -C -i -u -d "$ZSH_COMPDUMP"
fi
# ------------------------------------------------------------------------------ }}}

# Named directories {{{
# ------------------------------------------------------------------------------
hash -d dotfiles="${DOT_DIR:-$HOME/.dotfiles}"
hash -d developer="${PROJECTS:-$HOME/Developer}"
hash -d downloads="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
hash -d icloud="${HOME}/Library/Mobile Documents/com~apple~CloudDocs"
# ------------------------------------------------------------------------------ }}}

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
