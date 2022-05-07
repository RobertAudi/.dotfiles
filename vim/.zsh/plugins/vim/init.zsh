path=(/Applications/Neovide.app/Contents/MacOS(N-/) $path)
fpath=("$ZSH_HOME/plugins/vim/completions" $fpath)

function {
  emulate -L zsh
  setopt extended_glob
  autoload -Uz $ZSH_HOME/plugins/vim/completions/*~(*~|*.zwc)(-N.:t)
}

export NVIM_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
export NVIM_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"

if type nvim >/dev/null; then
  export VIM_COMMAND="nvim"
else
  export VIM_COMMAND="vim"
fi

alias vim="\$=VIM_COMMAND"
alias view="\$=VIM_COMMAND -R"
alias vi="\$=VIM_COMMAND -u NONE -U NONE"
