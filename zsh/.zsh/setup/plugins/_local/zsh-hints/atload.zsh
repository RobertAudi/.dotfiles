export ZSH_HINTS_DIR="$XDG_DATA_HOME/zsh/hints"

zstyle ':zsh-hints:*:' dir "$ZSH_HINTS_DIR"
zstyle ':zsh-hints:*:' margin 10
zstyle ':zsh-hints:*:' pri_sep "  ▶ "

for f in $ZSH_HINTS_DIR/*.hints(:t:r); do
  zle -N zsh-hints-$f zsh-hints
done

function list-zsh-hints {
  builtin print -l -- $ZSH_HINTS_DIR/*.hints(:t:r)
}

function -show-zsh-hint {
  local -a hints
  hints=($(list-zsh-hints))

  local hint
  hint=$(builtin print -l -- $hints | fzf-tmux +1 -m -d $((10 + ${#hints})))

  if [[ -n "$hint" ]]; then
    zle zsh-hints-$hint -w
  fi
}

zle -N -- -show-zsh-hint
bindkey -M emacs "$key_info[Control]X/" -show-zsh-hint
