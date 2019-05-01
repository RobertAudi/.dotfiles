if type nvim >/dev/null; then
  export VIM_COMMAND="nvim"
else
  export VIM_COMMAND="vim"
fi

if type vimr >/dev/null; then
  export GVIM_COMMAND="vimr"
  export GVIEW_COMMAND="$GVIM_COMMAND --nvim -R"
elif type mvim >/dev/null; then
  export GVIM_COMMAND="mvim"
fi

alias vim="\$VIM_COMMAND"
alias view="\$VIM_COMMAND -R"
alias vi="\$VIM_COMMAND -u NONE -U NONE"
alias gvim="\$GVIM_COMMAND"
alias gview="\$GVIEW_COMMAND"
