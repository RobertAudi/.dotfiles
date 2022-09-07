autoload -Uz $ZSH_HOME/completions/*(:t)

# zinit completions
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Cache stuff
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "$ZSH_COMPCACHE"

# Do not require running "rehash" manually
zstyle ':completion:*' rehash true

# This way you tell zsh comp to take the first part of the path to be exact,
# and to avoid partial globs. Now path completions became nearly immediate.
zstyle ':completion:*' accept-exact '*(N)'

# highlight matching part of available completions
zstyle ':completion:*' list-colors 'reply=( "=(#b)(*$PREFIX)(?)*=00=$color[green]=$color[bg-green]" )'

# remove slash if argument is a directory
zstyle ':completion:*' squeeze-slashes true

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*:*:open:*' matcher 'm:{a-z}={A-Z} r: ||[^ ]=**'
zstyle ':completion:*:match:*' original only

# If this style is set to 'true', it will add both '.' and '..' as possible completions.
# If it is set to '..', only '..' will be added.
#
# Set special-dirs to '..' when the current prefix:
#  - Is empty
#  - Is a single '.'
#  - Consists only of a path beginning with '../'
# Otherwise the value is 'false'.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

# Increase the number of errors based on the length of the typed word.
# Allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

# Case-insensitive (all), partial-word, and then substring completion.
zstyle ':completion:*' matcher-list \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# how many completions switch on menu selection
# use 'long' to start menu compl. if list is bigger than screen
# or some number to start menu compl. if list has that number
# of completions (or more).
zstyle ':completion:*:*:*:*:*' menu select

# Group matches and describe.
zstyle ':completion:*:matches'      group 'yes'
zstyle ':completion:*:options'      description 'yes'
zstyle ':completion:*:options'      auto-description '%d'
zstyle ':completion:*:corrections'  format ' %F{red}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages'     format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings'     format ' %F{red}-- no matches found --%f'
zstyle ':completion:*'              format ' %F{yellow}-- %d --%f'
zstyle ':completion:*'              group-name ''
zstyle ':completion:*'              list-grouped true
zstyle ':completion:*'              list-dirs-first true
zstyle ':completion:*'              verbose true
zstyle ':completion:*'              select-prompt '%SScrolling active: current selection at %P Lines: %m'
zstyle ':completion:*:default'      list-prompt '%S%M matches%s'
zstyle ':completion:*:default'      list-colors '${PREFIX:+=(#bi)($PREFIX:t)(?)*==31=1;32}':${(s.:.)LS_COLORS}

# If there are more than 5 options, allow selecting from a menu with
# arrows (case insensitive completion!).
zstyle ':completion:*-case' menu select=5

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# Ignore useless commands and functions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'

# Array completion element sorting
# Offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

# Do not prompt to cd into current directory.
# For example, cd ../<tab> should not prompt current directory.
zstyle ':completion:*:*:cd:*' ignore-parents parent pwd ..

# Environmental Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Man pages
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*:man:*' menu yes select

# Ignore multiple entries.
zstyle ':completion:*:(rm|diff|killall|pkill|kill):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Media Players
zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'

# ping hosts
zstyle ':completion:*:ping:*' hosts 8.8.8.8 google.com github.com

# ---------------------------------------------------------------------
# History
# ---------------------------------------------------------------------
# Ignore duplicate entries
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes

# Insert all expansions for expand completer
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# Processes
# ---------------------------------------------------------------------
# If the zsh/complist module is loaded, this style can be used to set
# color specifications. This mechanism replaces the use of the
# ZLS_COLORS and ZLS_COLOURS parameters.
# PIDs (bold red)
zstyle ':completion:*:processes' command 'ps -u $USER -o pid,user,command -w'
zstyle ':completion:*:processes' list-colors '=(#b)( #[0-9]#)[^[/0-9a-zA-Z]#(*)=34=37;1=30;1'
zstyle ':completion:*:*:(killall|pkill|kill):*:processes' list-colors '=(#bi) #([0-9]#) #([^ ]#) #([^ ]#) ##*($PREFIX)*==1;31=1;35=1;33=1;32=}'
zstyle ':completion:*:*:(killall|pkill|kill):*' menu yes select
zstyle ':completion:*:*:(killall|pkill|kill):*' force-list always
zstyle ':completion:*:*:(killall|pkill|kill):*' insert-ids single
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
# SSH/SCP/FTP/RSYNC/MOSH
# ---------------------------------------------------------------------
# Populate hostname completion.
local -a _global_ssh_hosts _ssh_hosts _etc_hosts hosts

if [[ -r /etc/ssh/ssh_known_hosts ]]; then
  _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*})
fi

if [[ -r ~/.ssh/known_hosts ]]; then
  _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*})
fi

if [[ -r ~/.ssh/config ]]; then
  # from http://serverfault.com/questions/170346
  _ssh_config=(${=${${${(@M)${(f)"$(cat ~/.ssh/config(N) /dev/null)"}:#Host *}#Host }:#*[*?]*}})
fi

if [[ -r /etc/hosts ]]; then
  : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}}
fi

hosts=("$_ssh_config[@]" "$_global_ssh_hosts[@]" "$_ssh_hosts[@]" "$_etc_hosts[@]" "$HOST" localhost)

zstyle ':completion:*:hosts' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp|rsync|mosh):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp|rsync|mosh):*' users $users
zstyle ':completion:*:(ssh|scp|ftp|rsync|mosh):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*'    group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:(ssh|ftp|mosh):*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|ftp|rsync|mosh):*:hosts-host'   ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|ftp|rsync|mosh):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|ftp|rsync|mosh):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

unset _global_ssh_hosts _ssh_hosts _etc_hosts hosts

# ---------------------------------------------------------------------

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
  Guest adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
  dbus distcache dovecot fax ftp games gdm gkrellmd gopher hacluster   \
  haldaemon halt hsqldb ident junkbust ldap lp mail mailman mailnull   \
  mldonkey mysql nagios named netdump news nfsnobody nobody nscd ntp   \
  nut nx openvpn operator pcap postfix postgres privoxy pulse pvm      \
  quagga radvd rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

# ---------------------------------------------------------------------
# Hide Shit
# ---------------------------------------------------------------------
zstyle ':completion:*:*' ignored-patterns '*.zwc' '*.old' 'broadcasthost' '*?.pyc'

# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns  '*?.(o|c~|old|pro|zwc)' '*~'

# Don't list tmux command aliases in completion results
zstyle ':completion:*:*:tmux:*:subcommands' mode 'commands'

# An array (colon separated list) containing the suffixes of files to
# be ignored during filename completion. However, if completion only
# generates files with suffixes in this list, then these files are
# completed anyway.
# Note: U can use ``ls **/*~*(${~${(j/|/)fignore}})(.)'' to list all
#       plain files that do not have extensions listed in `fignore' or
#       ``rm **/*(${~${(j/|/)fignore}})(.)'' to remove.
fignore=(.DS_Store .part ,v .aux .toc .lot .lof .blg .bbl .bak .BAK .sav .old .o .trace .swp \~)

compdef _functions refunc
compdef which-less=which
compdef cat-which=which

# Load NPM completion.
if is-command npm; then
  cache_file="${TMPDIR:-/tmp}/node-cache.$UID.zsh"

  if [[ "$commands[npm]" -nt "$cache_file" || ! -s "$cache_file" ]]; then
    # npm is slow; cache its output.
    npm completion >! "$cache_file" 2> /dev/null
  fi

  source "$cache_file"
  unset cache_file
fi
