if is-callable dircolors ; then
  # GNU Core Utilities
  # ------------------
  # LS_COLORS
  if [[ -s "$XDG_DATA_HOME/LS_COLORS" ]]; then
    eval "$(dircolors --sh "$XDG_DATA_HOME/LS_COLORS")"
  else
    eval "$(dircolors --sh)"
  fi

  # Options:
  #   -v                     natural sort of (version) numbers within text
  #   -F --classify          append indicator (one of */=>@|) to entries
  #   -B --ignore-backups    do not list implied entries ending with ~
  #   -h --human-readable    print human readable sizes (e.g., 1K 234M 2G)
  #
  #   --group-directories-first
  #       group directories before files
  #
  #   --dereference-command-line-symlink-to-dir
  #       follow symbolic links that point to a directory
  alias ls="${aliases[ls]:-ls} -Bv --color=auto --group-directories-first --dereference-command-line-symlink-to-dir"
  alias l="${aliases[l]:-ls -l} --ignore=.git --time-style=+'-'"
else
  # BSD Core Utilities
  # ------------------
  # Define colors for BSD ls.
  export LSCOLORS="exfxcxdxbxGxDxabagacad"

  # Define colors for the completion system.
  export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:"

  # Options:
  #   -F    append indicator (one of */=>@|) to entries
  #   -G    enable colorized output.
  #   -h    print human readable sizes (e.g., 1K 234M 2G)
  #   -H    follow symbolic links
  alias ls="${aliases[ls]:-ls} -GH"
  alias l="${aliases[ls]:-ls} -og"
fi

# The parameters ZLS_COLORS and ZLS_COLOURS are the lowest-level part of the system used by zsh/complist and describe how
# matches are highlighted. It has essentially the same format as $LS_COLORS.
#
# See: http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
export ZLS_COLORS=$LS_COLORS

if is-callable exa ; then
  alias exa="exa --time-style=long-iso --group-directories-first --colour=always"
  alias ll="exa -lgh --git"
  alias la="exa -a"
  alias lla="ll -a"
else
  alias ll="ls -l"
  alias la="ls -A"
  alias lla="ls -Al"
fi
