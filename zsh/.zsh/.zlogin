[[ -o interactive && -t 2 && $SHLVL -le 3 ]] && {
  # Execute code that does not affect the current session in the background.
  { silent zrecompile-all } &!

  chucknorris-says
  print

  print -P -- "%245FIn: %F{yellow}%~%f"
  ls-overview
  vcs-status-overview
} >&2
