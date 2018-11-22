# clear sudo auth cache
sudo -k

if [[ -o interactive && -t 2 && $SHLVL -le 3 ]]; then
  # clear terminal
  clear-buffer
fi
