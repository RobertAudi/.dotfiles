autoload -Uz zargs

export FORTUNES_DIR="$HOME/.local/share/fortunes"

typeset -ga fortunes cows
fortunes=($(sort -u <(zargs -n1 $FORTUNES_DIR/*(:t:r))))
cows=($(sort -u <(zargs -n1 /usr/local/share/cows/*.cow(:t:r))))

function {
  for f in $fortunes; do
    if [[ ! -f "$FORTUNES_DIR/$f.dat" ]]; then
      strfile "$FORTUNES_DIR/$f" "$FORTUNES_DIR/$f.dat" &>/dev/null
    fi
  done
} &!

cowmood() {
  local cow="${cows[RANDOM%$#cows+1]}"

  if (($RANDOM > $RANDOM)); then
    cowthink -f "$cow" "$@"
  else
    cowsay -f "$cow" "$@"
  fi
}

they-say() {
  zparseopts -D -E q=quiet_mode -quiet=quiet_mode

  local teller
  if [[ $# -eq 0 || ! -f "$FORTUNES_DIR/$1" ]]; then
    teller="${fortunes[RANDOM%$#fortunes+1]}"
  else
    teller="$1"
  fi

  if [[ -z "$quiet_mode" ]]; then
    echo
    fortune -s -n 100 -a "$FORTUNES_DIR/$teller" | cowmood | toilet --gay -f term
    echo
  else
    fortune -s -n 100  -a "$FORTUNES_DIR/$teller"
  fi
}

# Bastard Operator From Hell
# https://en.wikipedia.org/wiki/Bastard_Operator_From_Hell
bofh-says() {
  they-say "bofh-excuses" "$@"
}

chucknorris-says() {
  they-say "chucknorris" "$@"
}
