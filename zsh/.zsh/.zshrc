[ -n "$PROFILE_INIT" ] && zmodload zsh/zprof

[[ -v ZINIT ]] || typeset -A ZINIT

# # Commented out because it doesn't work on Apple Silicon
# module_path+=("${ZINIT_HOME}/mod-bin/zmodules/Src")
# zmodload zdharma-continuum/zinit

#   umask   directory   file
#   002     775         664
#   022     755         644
umask 022
limit coredumpsize 0

# Disable C-s and C-q for job control
stty -ixon -ixoff
stty start undef
stty stop undef

export SSH_PUBLIC_KEY=$(<$HOME/.ssh/id_ed25519.pub)

if [[ (-v ITERM_SESSION_ID || -v WEZTERM_UNIX_SOCKET) && -f "${XDG_DATA_HOME}/base16/base16-shell/base16-railscasts.sh" ]]; then
  source "${XDG_DATA_HOME}/base16/base16-shell/base16-railscasts.sh"
fi

if [[ -f "$ZDOTDIR/setup/perl.zsh" ]]; then
  source "$ZDOTDIR/setup/perl.zsh"
fi

# Required because otherwise it goes to shit.....
autoload -Uz zstyle+

if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"

  if [[ -n "$ZINIT_LOADFILE" && -f "$ZINIT_LOADFILE" ]]; then
    source "$ZINIT_LOADFILE"
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
typeset -gU pkg_config_path
typeset -gU fpath

export PATH SUDO_PATH MANPATH INFOPATH PKG_CONFIG_PATH FPATH

[ -n "$PROFILE_INIT" ] && zprof
