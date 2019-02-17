if type fd >/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
elif type rg >/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
elif type ag >/dev/null; then
  export FZF_DEFAULT_COMMAND='ag --hidden --files-with-matches -g ""'
fi

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
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
    -1 -0 --extended --cycle --no-hscroll --height 40%
    --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
    --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
    --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
  "
}

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

alias gco="fzf-git-checkout"
compdef _git fzf-git-checkout=git-checkout

fpath=("$ZSH_HOME/plugins/fzf/functions" $fpath)
function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/fzf/functions/*~(*~|*.zwc)(-N.:t)
}
