: ${FZF_HOME:=${HOME}/.local/opt/fzf}
export FZF_HOME

if type fd >/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
elif type rg >/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
elif type ag >/dev/null; then
  export FZF_DEFAULT_COMMAND='ag --hidden --files-with-matches -g ""'
fi

export FZF_HEIGHT="40%"
export FZF_TMUX_HEIGHT="30%"

function {
  local color00='#2b2b2b'
  local color01='#272935'
  local color02='#3a4055'
  local color03='#5a647e'
  local color04='#d4cfc9'
  local color05='#e6e1dc'
  local color06='#f4f1ed'
  local color07='#f9f7f3'
  local color08='#da4939'
  local color09='#cc7833'
  local color0A='#ffc66d'
  local color0B='#a5c261'
  local color0C='#519f50'
  local color0D='#6d9cbe'
  local color0E='#b6b3eb'
  local color0F='#bc9458'

  export FZF_DEFAULT_OPTS="
    --exit-0
    --extended
    --cycle
    --no-hscroll
    --height $FZF_HEIGHT
    --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
    --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
    --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
  "
}

path=($FZF_HOME/bin(N-/) $path)
fpath=($ZSH_HOME/plugins/fzf/{functions,functions/zle} $fpath)
manpath=($FZF_HOME/man(N-/) $manpath)

function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/fzf/{functions,functions/zle}/*~(*~|*.zwc)(-N.:t)
}

fs() { print-deprecated "Use PREFIX-Space instead" }
fcoc() { print-deprecated "Use gco instead" }

alias fzf="smart-fzf"

# Ctrl-r - Paste the selected command from history into the command line
zle -N fzf-history-widget
bindkey -M emacs '\C-r' fzf-history-widget
