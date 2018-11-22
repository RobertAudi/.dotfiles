export ZSH_HINTS_DIR="$XDG_DATA_HOME/zsh/hints"

zstyle ':zsh-hints:*:' dir "$ZSH_HINTS_DIR"
zstyle ':zsh-hints:*:' margin 10
zstyle ':zsh-hints:*:' pri_sep "  ▶ "

for f in $ZSH_HINTS_DIR/*.hints(:t:r); do
  zle -N zsh-hints-$f zsh-hints
done

show-zsh-hints() {
  local -a hints
  hints=($ZSH_HINTS_DIR/*.hints(:t:r))

  local hint
  hint=$(echo $hints | tr " " "\n" | fzf-tmux +1 -m -d $((10 + $(wc -l <<< "$hints"))))

  if [[ -n "$hint" ]]; then
    zle zsh-hints-$hint -w
  fi
}

zle -N show-zsh-hints
bindkey -M emacs "$key_info[Control]X/" show-zsh-hints
