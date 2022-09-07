# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -le 3 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# vim: ft=zsh
