for f in ~/.bash/*.{ba,}sh; do
  source $f
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
