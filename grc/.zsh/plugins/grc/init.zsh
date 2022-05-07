if [[ "$TERM" != dumb ]] && (( $+commands[grc] )) ; then
  # Supported commands
  cmds=(
    cc \
    configure \
    cvs \
    diff \
    dig \
    gcc \
    gmake \
    ifconfig \
    iwconfig \
    last \
    ldap \
    lsof \
    make \
    mount \
    mtr \
    netstat \
    nmap \
    ps \
    traceroute \
    traceroute6 \
    uptime \
    wdiff \
    whois \
  );

  # Set alias for available commands.
  for cmd in $cmds ; do
    if (( $+commands[$cmd] )) ; then
      alias $cmd="grc --stderr --stdout --colour=auto $(whence $cmd)"
    fi
  done

  if ! is-callable dust ; then
    alias du="grc --stderr --stdout --colour=auto $(whence du)"
  fi

  if ! is-callable duf ; then
    alias df="grc --stderr --stdout --colour=auto $(whence df)"
  fi

  if ! is-callable gping ; then
    alias ping="grc --stderr --stdout --colour=auto $(whence ping)"

    if is-callable ping6 ; then
      alias ping6="grc --stderr --stdout --colour=auto $(whence ping6)"
    fi
  fi

  # Clean up variables
  unset cmds cmd
fi
