[ -n "$PROFILE_INIT" ] && zmodload zsh/zprof

module_path+=("$HOME/.zplugin/bin/zmodules/Src")
zmodload zdharma/zplugin

#   umask   directory   file
#   002     775         664
#   022     755         644
umask 022
limit coredumpsize 0

# Disable C-s and C-q for job control
stty -ixon -ixoff
stty start undef
stty stop undef

export SSH_PUBLIC_KEY=$(<$HOME/.ssh/id_rsa.pub)

if [[ ! -v LESSOPEN ]] && [[ -f "/usr/local/bin/lesspipe.sh" ]]; then
  export LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
  export LESS_ADVANCED_PREPROCESSOR=1
fi

if [[ -f "$ZDOTDIR/setup/perl.zsh" ]]; then
  source "$ZDOTDIR/setup/perl.zsh"
fi

# Base16 Shell
export BASE16_SHELL="$XDG_DATA_HOME/base16/base16-shell"

if [[ -f "$BASE16_SHELL/base16-railscasts.sh" ]]; then
  source "$BASE16_SHELL/base16-railscasts.sh"
fi

# Required because otherwise it goes to shit.....
autoload -Uz zstyle+

if [[ -n "$ZPLG_HOME" && -f "$ZPLG_HOME/bin/zplugin.zsh" ]]; then
  source "$ZPLG_HOME/bin/zplugin.zsh"

  if [[ -n "$ZPLG_LOADFILE" && -f "$ZPLG_LOADFILE" ]]; then
    source "$ZPLG_LOADFILE"
  fi
fi

for f in $ZSH_HOME/*.zsh; do
  source $f
done
unset f

if [[ -f "$ZSH_HOME/.zshrc.private" ]]; then
  source "$ZSH_HOME/.zshrc.private"
fi

if [[ -f "$ZSH_HOME/.zshrc.local" ]]; then
  source "$ZSH_HOME/.zshrc.local"
fi

# Remove duplicate path entries
typeset -gU path
typeset -gU sudo_path
typeset -gU manpath
typeset -gU infopath
typeset -gU fpath

export PATH SUDO_PATH MANPATH INFOPATH FPATH

[ -n "$PROFILE_INIT" ] && zprof
