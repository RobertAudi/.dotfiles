is_linux || return 0

if is-command powerpill; then
  export PACMAN="powerpill"
fi

if ! is-callable open && is-command xdg-open; then
  open() { (xdg-open $1 &) &>/dev/null }
fi

if is-command xclip; then
  if ! is-callable pbcopy; then
    pbcopy()  { xclip -selection clipboard -in  $@ }
  fi
  if ! is-callable pbpase; then
    pbpaste() { xclip -selection clipboard -out $@ }
  fi
elif is-command xsel; then
  if ! is-callable pbcopy; then
    pbcopy()  { xsel -clipboard -input  $@ }
  fi
  if ! is-callable pbpase; then
    pbpaste() { xsel -clipboard -output $@ }
  fi
fi

if ! is-callable say && is-command espeak; then
  say() { espeak "$@" }
fi

mvim() {
  print -P -- "%F{196}DEPRECATED%f -- Use '%F{032}gvim%f' instead! "
  return 1
}

qdep() {
  pacman-color -Q $@ $(pacman -Qi $@ \
    | grep "Depends" \
    | cut -d: -f2- \
    | sed -E 's|>\S+\>||g')
}

# -------------------------------------------------------------------
# nice mount (http://catonmat.net/blog/another-ten-one-liners-from-commandlingfu-explained)
# displays mounted drive information in a nicely formatted manner
# -------------------------------------------------------------------
nicemount() {
  (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t
}

if is-callable xprop; then
  alias "app-info"='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
fi

if is-callable feh; then
  alias ql="feh"
fi

if is-command keychain; then
  eval $(keychain --eval --quiet --noask --nogui --agents ssh id_rsa)
fi

# -------------------------------------------------------------------
# Plugins
# -------------------------------------------------------------------
try-source "$ZSH_HOME/plugins/pacman/init.zsh"
