clear-screen-plus() {
  command clear; cd .
  zle reset-prompt
}
zle -N clear-screen-plus
bindkey -M emacs "$key_info[Control]l" clear-screen-plus

# just type '...' to get '../..'
rationalise-dot() {
  if [[ $_IS_PASTING = 1 ]]; then
    zle self-insert
    return
  fi

  local -a split
  split=( ${=LBUFFER} )
  local dir=$split[-1]

  if [[ $LBUFFER =~ '(^|/| |	|'$'\n''|\||;|&)(\.\./)+$' ]]; then
    zle self-insert
    zle self-insert
    LBUFFER+=/
    [ -e $dir ] && zle -M $dir(:a:h)
  elif [[ $LBUFFER =~ '(^|/| |	|'$'\n''|\||;|&)\.$' ]]; then
    zle self-insert
    LBUFFER+=/
    [ -e $dir ] && zle -M $dir(:a:h)
  else
    zle self-insert
  fi
}
zle -N rationalise-dot
bindkey -M emacs "." rationalise-dot

# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

fancy-ctrl-z() {
  if [[ $#BUFFER -eq 0 ]]; then
    if (( ${#jobstates} )); then
      # zle .push-input # ???
      [[ -o hist_ignore_space ]] && BUFFER=' ' || BUFFER=''
      BUFFER="${BUFFER}fg"
      zle .accept-line
    else
      zle -M 'No background jobs. Doing nothing.'
    fi
  else
    zle .push-input
    zle .clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey -M emacs "$key_info[Control]z" fancy-ctrl-z

toggle-sudo() {
  if [[ $UID -ne 0 ]]; then
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
      LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
      LBUFFER="${LBUFFER#$EDITOR }"
      LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
      LBUFFER="${LBUFFER#sudoedit }"
      LBUFFER="$EDITOR $LBUFFER"
    else
      LBUFFER="sudo $LBUFFER"
    fi
    zle end-of-line
  fi
}
zle -N toggle-sudo
bindkey -M emacs "$key_info[Escape]s" toggle-sudo

autoload -Uz incremental-complete-word && zle -N incremental-complete-word
bindkey -M emacs "$key_info[Control]xi" incremental-complete-word

# M-m will copy the last word of the current line
#
# Stolen from http://chneukirchen.org/dotfiles
#   http://chneukirchen.org/dotfiles/.zshrc
#   http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey -M emacs "$key_info[Escape]m" copy-earlier-word

# Expands all aliases, including global
function glob-alias {
  zle _expand_alias
  zle expand-word
  zle magic-space
}
zle -N glob-alias
bindkey -M emacs "$key_info[Control] " glob-alias

# Displays an indicator when completing.
function expand-or-complete-with-indicator {
  print -Pn "%B%F{red}...%f%b"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-indicator

# Complete in the middle of word.
# Display an indicator when completing.
bindkey -M emacs "$key_info[Control]I" expand-or-complete-with-indicator
