alias calc="noglob calc"
alias ff="noglob ff"
alias sfind="noglob sfind"

# Suffix aliases {{{
# ------------------------------------------------------------------------------

# Text files
alias -s txt='cat'

# Website
alias -s {org,com,fr,html,htm}="$BROWSER"

# PDF and PostScript
alias -s {pdf,ps}="$PDF_READER"

# Images
alias -s {gif,jpg,jpeg,png,bmp}="$IMAGE_VIEWER"

# JAR files
alias -s jar="java -jar"

# ------------------------------------------------------------------------------ }}}

#  VIM related aliases ;o) btw. ``$SHELL:t'' is a modifiers from the Z
#  Shell. In other shells you can use ``${SHELL##*/}'' instead. Valid
#  Modifiers can be found in ``info -f zsh -n Modifiers''.
alias :{w,q,wq,qa,wqa,x}{,!}='echo "This is $SHELL:t and not Vi(m)"'
alias :{Q,Qa,QA,Wa,WA,Wq,WQ,Wqa,WQa,WQA}{,!}='echo "This is $SHELL:t and not Vi(m)"'

if is-callable ag; then
  # Make ag pretty
  alias ag="ag --smart-case --color-match='30;31' --color-line-number='31;35' --color-path='31;34'"
fi

# Usefull globals
if is-callable rg; then
  alias -g "?"="| rg"
elif is-callable ag; then
  alias -g "?"="| ag"
else
  alias -g "?"="| grep"
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
alias ltree='tree -Chuapl'

# print info about a command, alias, function...
alias w="where"
alias '??=whence -ca'
alias '???=cat-which'

alias mvi="mv-interactive"

# Output total time to load zsh.
alias loadtime="time zsh -i -c exit >/dev/null"

# Profile the run time of this file.
alias whyslow="PROFILE_INIT=true zsh -i -c exit"

# Copy the pwd to the clipboard
alias pc="pcf \$PWD"

alias timestamp="date +%s"

# Copy last command
alias cpc="copy-last-command"

# Move to the dotfiles
alias dot='cd $DOTFILES_DIR'

alias unstow="stow -D"
alias restow="stow -R"

alias pong="ping www.google.com"

# Curl weather
alias weather="curl -q wttr.in"

# Display an animated party parrot
alias parrot="curl -q parrot.live"

if is-callable prettyping; then
  alias pping="prettyping"
fi

# List zombie processes
alias "ps-zombies"="ps aux | awk '{ if (NR == 1 || \$8 == \"Z\") { print } }'"

# List open ports
alias "ls-open-ports"="lsof -i -n -P"

# Lists empty directories
alias "ls-empty-dirs"="find . -type d -empty | sort"

# todo.txt
alias t="todo.sh -d \$USER_TODO_DIR/config"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Misc (random shit really...)
alias grunts="grunt --list"

# Excuse me!
alias excuse="nc bofh.jeffballard.us 666 | tail -1"

# Taco - Stolen from https://github.com/neg-serg/dotfiles
#   https://github.com/neg-serg/dotfiles/blob/5c13bf4a435082a38817f702dae1d79c6ac97e94/zsh/.zsh/05-cmds.zsh#L526
alias taco='curl -L git.io/taco'

alias urlencode='ruby -r cgi -e "puts CGI.escape(ARGV[0])"'
alias urldecode='ruby -r cgi -e "puts CGI.unescape(ARGV[0])"'
alias urlencode_json='ruby -e "require \"uri\"; puts URI.escape(STDIN.read)"'
alias urldecode_json='ruby -e "require \"uri\"; puts URI.unescape(STDIN.read)"'
alias pp_json='ruby -e "require \"json\"; require \"yaml\"; puts JSON.parse(STDIN.read).to_yaml"'
alias is_json='ruby -e "require \"json\"; begin; JSON.parse(STDIN.read); puts true; rescue Exception => e; puts false; end"'

# Nyan Cat
if is-callable nc; then
  alias nyan="nc -v nyancat.dakko.us 23"
fi

if is-callable archey; then
  alias archey="archey --offline"
fi

if is-callable dfc; then
  alias dfc="dfc -Tdsow"
fi

# Modeline {{{
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker : }}}
