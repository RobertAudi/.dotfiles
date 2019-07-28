zle -N -- -clear-screen-plus
bindkey -M emacs "$key_info[Control]l" -clear-screen-plus

# just type '...' to get '../..'
zle -N -- -rationalise-dot
bindkey -M emacs "." -rationalise-dot

# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

zle -N -- -fancy-ctrl-z
bindkey -M emacs "$key_info[Control]z" -fancy-ctrl-z

zle -N -- -toggle-sudo
bindkey -M emacs "$key_info[Escape]s" -toggle-sudo

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
autoload -Uz -- -glob-alias
zle -N -- glob-alias
bindkey -M emacs "$key_info[Control] " glob-alias

# Displays an indicator when completing.
zle -N -- -expand-or-complete-with-indicator

# Complete in the middle of word.
# Display an indicator when completing.
bindkey -M emacs "$key_info[Control]I" -expand-or-complete-with-indicator
