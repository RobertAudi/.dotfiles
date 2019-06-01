local fasd_cache="$HOME/.cache/fasd-init"
if [[ "$(command -v fasd)" -nt "$fasd_cache" || ! -s "$fasd_cache" ]]; then
  fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >! "$fasd_cache"
fi

source "$fasd_cache"
unset fasd_cache

j() {
  if (( $# == 0 )); then
    print-info "Falling back to fasd"
    fasd -h
    return 1
  fi

  zparseopts -D -E -a fasd_opts A D s l i e: b: B: a d f r t R h 0 1 2 3 4 5 6 7 8 9
  if (( ${#fasd_opts} > 0 )); then
    print-info "Falling back to fasd"
    fasd ${=fasd_opts[@]} $@
  else
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 +s +m)" \
      && cd "${dir}" \
      || return 1
  fi
}
