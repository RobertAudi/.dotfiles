# Invalidate any existing sudo sessions
sudo -K 2> /dev/null || :

if [[ -o interactive && -t 2 && $SHLVL -le 3 ]]; then
  # Clear terminal
  clear-buffer
fi
