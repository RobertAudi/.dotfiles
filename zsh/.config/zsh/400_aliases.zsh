# Disable globbing {{{
# ------------------------------------------------------------------------------
alias ff="noglob ff"
alias sfind="noglob sfind"

if is-callable calc ; then
  alias calc="noglob calc"
fi

if is-callable fd ; then
  alias fd="noglob fd"
fi
# ------------------------------------------------------------------------------ }}}

# Suffix aliases {{{
# ------------------------------------------------------------------------------

# Text files
alias -s txt="cat"

# Website
alias -s {org,com,fr,html,htm}="$BROWSER"

# PDF and PostScript
alias -s {pdf,ps}="$PDF_READER"

# Images
alias -s {gif,jpg,jpeg,png,bmp}="$IMAGE_VIEWER"

# JAR files
alias -s jar="java -jar"

if is-callable jless ; then
  alias -s json="jless"
fi

# ------------------------------------------------------------------------------ }}}

# Global aliases {{{
# ------------------------------------------------------------------------------

if is-callable rg ; then
  alias -g "?"="| rg"
elif is-callable ag ; then
  alias -g "?"="| ag"
else
  alias -g "?"="| grep"
fi

# path-extractor
if is-callable path-extractor ; then
  alias -g ":pe"="| path-extractor"
fi

# Add snippets as global aliases as well
alias -g "::"="| \$PAGER"
alias -g ":_"="&>/dev/null"
alias -g ":+"="| wc -l"
alias -g ":c"="| and-pipe copy"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes :map dirname
alias -g ":map"="| xargs -n1"

# ------------------------------------------------------------------------------ }}}

#  VIM related aliases ;o) btw. ``$SHELL:t'' is a modifiers from the Z
#  Shell. In other shells you can use ``${SHELL##*/}'' instead. Valid
#  Modifiers can be found in ``info -f zsh -n Modifiers''.
alias :{w,q,wa,wq,qa,wqa,x}{,!}="tableflip; echo \"This is $SHELL:t and not Vi(m)\""
alias :{W,Q,Qa,QA,Wa,WA,Wq,WQ,Wqa,WQa,WQA}{,!}="tableflip; echo \"This is $SHELL:t and not Vi(m)\""

if is-callable ag ; then
  # Make ag pretty
  alias ag="ag --hidden --smart-case --color-match='30;31' --color-line-number='31;35' --color-path='31;34'"
fi

# chmod {u,g,a}{+,-}{x,w,r}
local mod target
for mod in x w r; do
  for target in u g a ""; do
    alias -- "${target}+$mod"="chmod ${target}+$mod"
    alias -- "${target}-$mod"="chmod -- ${target}-$mod"
  done
done

# Resource Usage
alias df="df -kh"
alias du="du -d1 -kh"

# Directory tree
alias dtree="tree -d"

# Source: https://github.com/lucc/shell-config
#   https://github.com/lucc/shell-config/blob/09243d6ee43fd49150055c3c27717ebf9b356691/aliases#L18
# Replacement for ls -lR
alias ltree="tree -Chuapl"

# print info about a command, alias, function...
alias w="where"
alias "??=whence -ca"
alias "???=cat-which"

alias mvi="mv-interactive"

# Output total time to load zsh.
alias loadtime="time zsh -i -l -c exit >/dev/null"

# Profile the run time of this file.
alias whyslow="PROFILE_INIT=true zsh -i -l -c exit"

# Copy the pwd to the clipboard
alias pc="pcf \$PWD"

alias timestamp="date +%s"

# Copy last command
alias cpc="copy-last-command"

# Move to the dotfiles
alias dot="cd \$DOTFILES_DIR"

alias unstow="stow -D"
alias restow="stow -R"

alias pong="ping www.google.com"

# Curl weather
alias weather="curl -q wttr.in"

if is-callable prettyping ; then
  alias pping="prettyping"
  alias ppong="prettyping www.google.com"
fi

if is-callable gping ; then
  alias ping="gping"
  alias ping6="gping -6"
fi

# List zombie processes
alias "ps-zombies"="ps aux | awk '{ if (NR == 1 || \$8 == \"Z\") { print } }'"

# Lists empty directories
alias "ls-empty-dirs"="find . -type d -empty | sort"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Excuse me!
alias excuse="nc bofh.jeffballard.us 666 | tail -1"

if is-callable archey ; then
  alias archey="archey --offline"
fi

if is-callable dfc ; then
  alias dfc="dfc -Tdsow"
fi

if is-callable pstree ; then
  alias pstree="pstree -g 3"
fi

if ! is-callable alacritty && [[ -x "/Applications/Alacritty.app/Contents/MacOS/alacritty" ]]; then
  alias alacritty="/Applications/Alacritty.app/Contents/MacOS/alacritty"
fi

if is-callable dust ; then
  alias du="dust"
fi

if is-callable duf ; then
  alias df="duf"
fi

if is-callable btm ; then
  alias top="btm"
else
  # fancy top
  alias top="top -ocpu -R -F -s 2 -n30"
fi

if is-callable cmatrix ; then
  alias cmatrix="cmatrix -fsba"
fi

if is-callable detox ; then
  # Replace problematic characters in filenames
  alias detox="detox -v"
fi

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
